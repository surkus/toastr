class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.string :type, null: false
      t.string :key

      t.string     :cache_state, length: 16
      t.text       :cache_json
      t.timestamp  :cached_at

      t.timestamps
    end
  end
end
