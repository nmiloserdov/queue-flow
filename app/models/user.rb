class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :answers,   dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes
  has_many :authorizations
  
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :omniauthable,
      omniauth_providers: [:facebook]

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider,
      uid: auth.uid.to_s).first
    return authorization.user if authorization

    email = auth.info[:email]
    user = User.where(email: email).first
    if user.nil?
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password,
        password_confirmation: password)
    end
    user.authorizations.create(provider: auth.provider, uid: auth.uid)
    user
  end
  
  def author_of?(post)
    self.id == post.user_id
  end
  
  def cut_name
    self.email.sub(/@.*./,'')
  end
end
