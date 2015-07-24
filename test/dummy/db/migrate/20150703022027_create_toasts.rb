class CreateToasts < ActiveRecord::Migration
  def change
    create_table :toastr_toasts, force: true do |t|
      t.references :parent,    null: false, polymorphic: true, index: true
      t.string     :category,  null: false
      t.jsonb      :cache_json
      t.text       :status,    null: false
      t.timestamps             null: true
    end

    add_index :toastr_toasts, [:parent_id, :parent_type, :category], unique: true, name: 'toasts_parent_category'
  end
end
