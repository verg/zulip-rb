require 'faraday'

module Zulip
  module Messages

    def send_message(subject, content, to_stream)
      post_message("stream", content, to_stream, subject)
    end

    def send_private_message(content, recipient_user)
      post_message("private", content, recipient_user)
    end

    private

    # recipient may be a stream or user-email
    def post_message(type, content, recipient, subject=nil)
      connection.post("v1/messages") do |request|
        params = { "type" => type, "content" => content, "to" => recipient }
        params = params.merge( { "subject" => subject } ) if subject
        request.params = params
      end
    end

  end
end
