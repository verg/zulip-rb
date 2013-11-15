module Zulip
  module EventParser
    def self.parse(event)
      case event['type']
      when "message"
        Zulip::Message.new event.fetch('message')
      when "heartbeat"
        # NOOP
      end
    end
  end
end
