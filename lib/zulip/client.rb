module Zulip
  class Client

    attr_accessor :bot_email_address, :bot_api_key

    def initialize
      yield self if block_given?
    end
  end
end
