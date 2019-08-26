class CreateBeaches < ActiveRecord::Migration
  def change
    create_table :beaches do |t|
      t.string :name
      t.string :city
      t.string :shore
      
      t.timestamps null: false
    end
  end
end
