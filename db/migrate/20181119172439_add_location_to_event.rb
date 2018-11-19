class AddLocationToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :location, :string, limit: 255
  end
end
