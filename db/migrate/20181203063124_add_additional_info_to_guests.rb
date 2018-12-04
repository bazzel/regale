class AddAdditionalInfoToGuests < ActiveRecord::Migration[5.2]
  def change
    add_column :guests, :additional_info, :string, limit: 500
  end
end
