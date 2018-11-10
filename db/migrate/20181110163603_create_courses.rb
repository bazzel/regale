class CreateCourses < ActiveRecord::Migration[5.2]
  def change
    create_table :courses do |t|
      t.string :title, limit: 100
      t.string :description, limit: 255
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_column :events, :courses_count, :integer, default: 0
  end
end
