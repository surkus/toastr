class CreateToasts < ActiveRecord::Migration
  def self.up
    create_table :toastr_toasts, force: true do |t|
      t.references :parent, polymorphic: true
      t.string :category
      t.text :cache_json
      t.text :status
      t.timestamps null: true
    end

    # add_index :toasts, :status, name: 'toasts_status'
  end

  def self.down
    drop_table :toastr_toasts
  end
end