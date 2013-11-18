module Zulip
  module StreamSubscriptions

    def get_subscriptions
      get_subscriptions_response.map do |subscription|
        Zulip::StreamSubscription.new(subscription)
      end
    end

    def subscribe(streams)
      patch_subscriptions subscribe_params(streams)
    end

    private

    def get_subscriptions_response
      parse_response(connection.get(subscription_urn)).fetch("subscriptions") { [] }
    end

    def subscription_urn
      'v1/users/me/subscriptions'
    end

    def subscribe_params(streams)
      { add: json_encoded_streams(streams) }
    end

    def json_encoded_streams(streams)
      streams = Array(streams).map { |subscription_name| { name: subscription_name } }
      json_encode_list(streams)
    end

    def patch_subscriptions(req_params)
      parse_response(connection.patch(subscription_urn, req_params))
    end

  end
end
