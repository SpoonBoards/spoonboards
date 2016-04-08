class User < ActiveRecord::Base
  has_secure_password
  has_many :boards
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true

  def self.sign_in_from_omniauth(auth)
    find_by(provider: auth['provider'], uid['uid']) || create_user_from_omniauth(auth)
  end

  def self.create_user_from_omniauth(auth)
    create(
    provider: auth['provider'],
    uid: auth['uid'],
    name: auth['info']['name']
    )
  end

end
