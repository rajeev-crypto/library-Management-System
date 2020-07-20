class AddDatesToCheckOutLog < ActiveRecord::Migration[5.2]
  def change
    add_column :check_out_logs, :check_out_date, :date
    add_column :check_out_logs, :check_in_date, :date
  end
end
