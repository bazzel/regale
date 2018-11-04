class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :title, limit: 100
      t.datetime :scheduled_at

      t.timestamps
    end
  end
end
