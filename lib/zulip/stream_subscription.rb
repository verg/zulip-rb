module Zulip
  class StreamSubscription
    attr_reader :name, :color, :notifications, :subscribers, :invite_only,
      :email_address, :in_home_view

    def initialize(attrs={})
      attrs.each do |name, value|
        instance_variable_set("@#{name}", value)
      end
    end
  end
end
