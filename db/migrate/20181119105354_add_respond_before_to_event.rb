class AddRespondBeforeToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :respond_before, :datetime
  end
end
