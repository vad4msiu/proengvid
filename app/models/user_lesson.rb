class UserLesson < ActiveRecord::Base
  include AASM

  belongs_to :user
  belongs_to :lesson

  validate :user, :lesson, presence: true

  aasm column: :state do
    state :unwatched, initial: true
    state :watched

    event :watch do
      transitions :from => :unwatched, :to => :watched
    end

    event :unwatch do
      transitions :from => :watched, :to => :unwatched
    end
  end
end