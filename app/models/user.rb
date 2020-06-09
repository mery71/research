class User < ApplicationRecord
    has_secure_password
    has_many :access_tokens, class_name: "Doorkeeper::AccessToken",
    foreign_key: :resource_owner_id, dependent: :destroy

    class << self
    def authenticate params
      user = User.find_by name: params[:name]
      return false unless user
      user.authenticate params[:password]
    end
  end
end
