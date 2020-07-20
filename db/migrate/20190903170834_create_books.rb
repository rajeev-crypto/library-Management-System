class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :author_id
      t.integer :genre_id
      t.boolean :checked_out
      t.integer :present_user_id

      t.timestamps
    end
  end
end
