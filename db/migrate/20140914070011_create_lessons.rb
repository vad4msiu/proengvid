class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.string :teacher
      t.string :name
      t.string :categories, array: true, default: []
      t.string :link, unique: true

      t.timestamps
    end
  end
end
