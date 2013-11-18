module Zulip
  class Client
    module EventStreaming

      def stream_messages(&block)
        stream_events("message", &block)
      end

      def stream_private_messages(&block)
        stream_raw_events("message") do |raw_event|
          yield parse_event(raw_event) if private_message?(raw_event)
        end
      end

      def stream_public_messages(&block)
        stream_raw_events("message") do |raw_event|
          yield parse_event(raw_event) if public_message?(raw_event)
        end
      end

      def stream_events(event_types, &block)
        stream_raw_events(event_types) do |raw_event|
          yield parse_event(raw_event)
        end
      end

      private

      def stream_raw_events(event_types, &block)
        queue = register(event_types)
        queue_id = queue.queue_id
        last_event_id = queue.last_event_id

        loop do
          events = get_events(queue_id, last_event_id)
          last_event_id = max_event_id_from(events)

          events.each do |event|
            yield event if event_types.include?(event["type"])
          end
        end
      end

      # Makes a longpulling request on an event queue
      def get_events(queue_id, last_event_id=nil)
        connection.params = build_get_event_params(queue_id, last_event_id)
        event_response.fetch("events")
      end

      def parse_event(raw_event)
        Zulip::Client::EventParser.parse(raw_event)
      end

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

    end
  end
end
