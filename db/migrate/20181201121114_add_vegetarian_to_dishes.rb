class AddVegetarianToDishes < ActiveRecord::Migration[5.2]
  def change
    add_column :dishes, :vegetarian, :boolean
  end
end
