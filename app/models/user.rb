class User < ActiveRecord::Base
  has_secure_password
  has_many :boards

  has_many :carts
  validates :name, presence: true


  def self.sign_in_from_omniauth(auth)
    find_by(provider: auth['provider'], uid: auth['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.name = auth['name'] || "#{auth['first_name']} #{auth['last_name']}"
      user.password = SecureRandom.hex
      user.save
      Cart.create!(user_id: user.id)
    end
  end

end
