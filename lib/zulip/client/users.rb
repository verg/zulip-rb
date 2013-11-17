module Zulip
  module Users
    def get_users
      request_users.map { |user_data| Zulip::User.new(user_data) }
    end

    private

    def request_users
      parse_response(connection.get('v1/users')).fetch("members")
    end
  end
end
