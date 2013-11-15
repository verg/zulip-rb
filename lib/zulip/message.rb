module Zulip
  class Message
    attr_reader :id, :recipient_id, :sender_email, :timestamp, :display_recipient,
      :sender_id, :sender_full_name, :sender_domain, :content, :gravatar_hash,
      :avatar_url, :client, :content_type, :subject_links, :sender_short_name,
      :type, :subject

    alias :stream :display_recipient

    def initialize(attrs={})
      attrs.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end

  end
end
