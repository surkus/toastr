class CreateToasts < ActiveRecord::Migration
  def change
    create_table :toastr_toasts, force: true do |t|
      t.references :parent, polymorphic: true, null: false, index: true
      t.string :category, null: false
      t.text :cache_json
      t.text :status, null: false
      t.timestamps null: true
    end

    add_index :toastr_toasts, [:parent_id, :parent_type, :category], unique: true, name: 'toasts_parent_category'
  end
end
