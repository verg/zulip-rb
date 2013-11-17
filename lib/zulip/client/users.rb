module Zulip
  module Users
    def get_users
      get_users_response.map { |user_data| Zulip::User.new(user_data) }
    end

    def get_subscriptions
      get_subscriptions_response.map { |subscription| StreamSubscription.new(subscription)}
    end

    private

    def get_users_response
      parse_response(connection.get('v1/users')).fetch("members")
    end

    def get_subscriptions_response
      parse_response(connection.get('v1/users/me/subscriptions'))
    end
  end
end
