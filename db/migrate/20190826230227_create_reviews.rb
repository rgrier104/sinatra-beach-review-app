class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :description
      t.integer :user_id
      t.integer :beach_id

      t.timestamps null: false
    end
  end
end
