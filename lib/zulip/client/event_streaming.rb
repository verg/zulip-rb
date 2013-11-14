module Zulip
  module EventStreaming

    # Accepts an object that responds to #queue_id && #last_event_id
    # Alternativly takes a queue id and a last event id
    def get_events(registered_queue_or_queue_id, last_event_id=nil)
      connection.params = build_get_event_params(registered_queue_or_queue_id, last_event_id)
      event_response
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
  end
end
