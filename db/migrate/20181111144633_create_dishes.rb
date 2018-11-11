class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :title, limit: 100
      t.string :description, limit: 255
      t.references :course

      t.timestamps
    end

    add_column :courses, :dishes_count, :integer, default: 0

    Course.all.each do |e|
      Course.reset_counters e.id, :dishes
    end
  end
end
