class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :answers,   dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :votes
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def author_of?(post)
    self.id == post.user_id
  end
  
  def cut_name
    self.email.sub(/@.*./,'')
  end
end

