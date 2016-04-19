# user
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :username, presence: true, uniqueness: true

  has_many :submissions
  has_many :questions
  has_many :scores

  def super?
    is_super
  end

  def email_required?
    false
  end

  def email_changed?
    false
  end

  def email
    'ogura.nop@gmail.com'
  end

  def email=(_args)
    'ogura.nop@gmail.com'
  end
end
