module Zulip
  module QueueRegistration
    EVENT_TYPES = { messages: "messages" }
    # TODO: Add support for other event types

    QueueRegistrationResponse = Struct.new(:queue_id, :last_event_id)

    def register(event_types, opts={})
      connection.params = { "event_types" => json_encode_list(event_types) }
      QueueRegistrationResponse.new(response['queue_id'], response['last_event_id'])
    end

    def response
      @response ||= JSON.parse(connection.post("/v1/register"))
    end
  end
end
