class CreateCheckOutLogs < ActiveRecord::Migration[5.2]
  def change
    create_table :check_out_logs do |t|
      t.string :comment
      t.integer :user_id
      t.integer :book_id

      t.timestamps
    end
  end
end
