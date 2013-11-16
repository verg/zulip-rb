module Zulip
  module EventStreaming

    def stream_messages(&block)
      stream_events("message", &block)
    end

    def stream_private_messages(&block)
      stream_events("message", yield_raw: true) do |event|
        yield Zulip::EventParser.parse(event) if private_message?(event)
      end
    end

    def stream_public_messages(&block)
      stream_events("message", yield_raw: true) do |event|
        yield Zulip::EventParser.parse(event) if public_message?(event)
      end
    end

    def stream_events(event_types, opts={}, &block)
      queue = register(event_types)
      queue_id = queue.queue_id
      last_event_id = queue.last_event_id

      loop do
        events = get_events(queue_id, last_event_id)
        last_event_id = max_event_id_from(events)

        events.each do |event|
          yield parsed_or_raw_event(event, opts) if event_types.include?(event["type"])
        end
      end
    end

    # Makes a longpulling request on an event queue
    # Accepts an object that responds to #queue_id && #last_event_id
    # Alternativly takes a queue id and a last event id
    def get_events(registered_queue_or_queue_id, last_event_id=nil)
      connection.params = build_get_event_params(registered_queue_or_queue_id, last_event_id)
      event_response.fetch("events")
    end

    private

    def build_get_event_params(registered_queue_or_queue_id, last_event_id)
      { 'queue_id' => find_queue_id(registered_queue_or_queue_id),
        'last_event_id' => last_event_id || registered_queue_or_queue_id.last_event_id }
    end

    def find_queue_id(registered_queue_or_queue_id)
      if registered_queue_or_queue_id.respond_to?(:queue_id)
        registered_queue_or_queue_id.queue_id
      else
        registered_queue_or_queue_id
      end
    end

    def event_response
      response = connection.get("/v1/events").body
      JSON.parse(response)
    end

    def max_event_id_from(events)
      events.map{ |event| event['id']}.max
    end

    def private_message?(event)
      event['message']['type'] == "private"
    end

    def public_message?(event)
      event['message']['type'] == "stream"
    end

    def parsed_or_raw_event(event, opts)
      if opts[:yield_raw]
        event
      else
        Zulip::EventParser.parse(event)
      end
    end
  end
end
