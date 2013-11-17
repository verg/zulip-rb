module Zulip
  class User
    attr_reader :email, :full_name
    def initialize(user_data)
      @email = user_data['email']
      @full_name = user_data['full_name']
    end
  end
end
