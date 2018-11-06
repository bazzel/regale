class AddGuestsCount < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :guests_count, :integer, default: 0
  end
end
