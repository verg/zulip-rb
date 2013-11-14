require 'faraday'

module Zulip
  module Messages

    def send_message(subject, content, to_stream)
      post_message("stream", content, to_stream, subject)
    end

    def send_private_message(content, *recipient_users)
      post_message("private", content, recipient_users)
    end

    private

    def post_message(type, content, recipients_or_stream, subject=nil)
      connection.params = build_post_message_params(type, content,
                                                    recipients_or_stream, subject)
      connection.post("v1/messages")
    end

    def build_post_message_params(type, content, recipients_or_stream, subject=nil)
      params = subject ? {"subject" => subject } : {}
      params = params.merge({ "type" => type, "content" => content,
                              "to" => json_encode_list(recipients_or_stream) })
    end

  end
end
