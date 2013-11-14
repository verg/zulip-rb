require 'json'

require 'zulip/client/messages'
require 'zulip/client/queue_registration'
require 'zulip/client/event_streaming'

module Zulip
  class Client
    include Zulip::Messages
    include Zulip::QueueRegistration
    include Zulip::EventStreaming

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

    def json_encode_list(items)
      JSON.generate(Array(items).flatten)
    end

  end
end
