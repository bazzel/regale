class AddAdditionalInfoToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :additional_info, :string, limit: 500
  end
end
