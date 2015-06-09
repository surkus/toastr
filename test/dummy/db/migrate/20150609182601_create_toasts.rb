class CreateToasts < ActiveRecord::Migration
  def change
    create_table :toastr_toasts, force: true do |t|
      t.references :parent, polymorphic: true
      t.string :category
      t.jsonb :cache_json
      t.text :status
      t.timestamps null: true
    end
  end
end
