class CreateOats < ActiveRecord::Migration
  def change
    create_table :oats do |t|

      t.timestamps
    end
  end
end
