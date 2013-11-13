require 'zulip/client/messages'

module Zulip
  class Client
    include Zulip::Messages

    attr_accessor :bot_email_address, :bot_api_key
    attr_writer :connection
    ENDPOINT = "https://api.zulip.com"

    def initialize
      yield self if block_given?
    end

    private

    def connection
      @connection ||= initialize_connection
    end

    def initialize_connection
      conn = Faraday.new(url: ENDPOINT)
      conn.basic_auth(bot_email_address, bot_api_key)
      conn
    end

  end
end
