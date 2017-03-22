class User
  include Mongoid::Document
  field :provider, type: String
  field :uid, type: String
  field :name, type: String
  field :token, type: String
  field :refresh_token, type: String

  def self.find_or_create_from_auth_hash(auth_hash)
    # Look up the user
    user = where(provider: auth_hash[:provider], uid: auth_hash[:uid]).first_or_create
    user.update(
      name:          auth_hash[:info][:display_name],
      token:         auth_hash[:credentials][:token],
      refresh_token: auth_hash[:credentials][:refresh_token]
    )
    user
  end
end
