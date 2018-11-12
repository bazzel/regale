class CreateDishes < ActiveRecord::Migration[5.2]
  def change
    create_table :dishes do |t|
      t.string :title, limit: 100
      t.string :description, limit: 255
      t.references :event
      t.string :type

      t.timestamps
    end
  end
end
