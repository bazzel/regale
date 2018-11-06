class CreateGuests < ActiveRecord::Migration[5.2]
  def change
    create_table :guests do |t|
      t.references :user, foreign_key: true
      t.references :event, foreign_key: true

      t.timestamps
    end

    add_column :events, :guests_count, :integer, default: 0

    Event.all.each do |e|
      Event.reset_counters e.id, :guests
    end
  end
end
