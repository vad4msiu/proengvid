class User < ActiveRecord::Base
  has_many :user_lessons, dependent: :destroy
  has_many :watched_lessons, through: :user_lessons, source: :lesson

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
