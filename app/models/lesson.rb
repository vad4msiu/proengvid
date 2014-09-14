class Lesson < ActiveRecord::Base
  validate :name, :teacher, :link, presence: true
  validate :link, uniqueness: true

  scope :categories_in, ->(categories) do
    where("categories && ARRAY[:categories]::varchar[]", categories: categories)
  end

  def self.ransackable_scopes(auth_object = nil)
    [:categories_in]
  end
end
