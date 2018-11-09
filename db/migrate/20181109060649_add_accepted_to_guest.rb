class AddAcceptedToGuest < ActiveRecord::Migration[5.2]
  def change
    add_column :guests, :accept_status, :integer
  end
end
