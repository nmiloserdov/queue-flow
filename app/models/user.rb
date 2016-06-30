class User < ActiveRecord::Base

  has_many :answers,   dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes
  has_many :authorizations, dependent: :destroy
  has_many :subscriptions, dependent: :destroy

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :trackable, :validatable, :omniauthable,
    omniauth_providers: [:facebook, :twitter]

  def author_of?(post)
    self.id == post.user_id
  end

  def subscribed_to?(question)
    self.subscriptions.map(&:question_id).include?(question.id)
  end

  def subscribe_to!(question)
    subscription = Subscription.new(user: self, question: question)
    true if subscription.save
  end

  def unsubscribe_from!(question)
    subscription = Subscription.find_by(user: self, question: question)
    true if subscription.destroy
  end
  
  def cut_name
    self.email.sub(/@.*./,'')
  end

  def confirm!
    self.authorizations.first.update(access: true, user_id: self.id)
    self.email = self.unconfirmed_email
    self.unconfirmed_email = nil
    self.confirmation_token = nil
    self.confirmed_at = Time.now
    self.save
  end

  def self.find_for_oauth(auth)
    authorization = Authorization.where(provider: auth.provider, uid: auth.uid.to_s).first
    if authorization.try(:user)
      authorization.user
    else
      self.build_authorization_for_ouath(auth)
    end
  end


  private

  def self.build_authorization_for_ouath(auth)
    email = auth.email || auth.try(:info).try(:email)
    user = User.where(email: email).first

    # creates auth for user if email is exists
    if user
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end

    # creates user and auth if email is present
    if user.nil? && email.present?
      password = Devise.friendly_token[0, 20]
      user = User.create!(email: email, password: password,
        password_confirmation: password)
      user.authorizations.create(provider: auth.provider, uid: auth.uid)
    end

    # creates user object and auth object for the further processing
    if email.nil? && user.nil?
      user = User.new(confirmation_token: Devise.friendly_token)
      user.authorizations.new(provider: auth.provider, uid: auth.uid, access: false)
    end

    return user
  end
end
