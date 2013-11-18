module Zulip
  class Client
    module QueueRegistration
      EVENT_TYPES = { message: "message" }
      # TODO: Add support for other event types
      # TODO: Add support setting apply markdown to false

      QueueRegistrationResponse = Struct.new(:queue_id, :last_event_id)

      def register(event_types=nil, opts={})

        if event_types
          connection.params = { "event_types" => json_encode_list(event_types) }
        end

        QueueRegistrationResponse.new( registration_response['queue_id'],
                                      registration_response['last_event_id'] )
      end

      def registration_response
        @registration_response ||= parse_json(connection.post("v1/register").body)
      end
    end
  end
end
