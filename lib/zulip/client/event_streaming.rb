module Zulip
  module EventStreaming

    def stream_messages(&block)
      stream_events("message", &block)
    end

    def stream_events(*event_types, &block)
      event_types.flatten!

      queue = register(event_types)
      queue_id = queue.queue_id
      last_event_id = queue.last_event_id

      loop do
        events = get_events(queue_id, last_event_id)
        last_event_id = max_event_id_from(events)

        events.each do |event|
          yield Zulip::EventParser.parse(event) if event_types.include?(event["type"])
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
  end
end
