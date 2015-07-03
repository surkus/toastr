class CreateToastrReports < ActiveRecord::Migration
  def change
    create_table :toastr_reports, force: true do |t|
      t.string :type, null: false
      t.text   :key, null: false
      t.timestamps
    end

    add_index :toastr_reports, [:type, :key], unique: true, name: 'toastr_reports_type_key'
  end
end
