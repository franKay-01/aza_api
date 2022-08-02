class AddFieldsToTransaction < ActiveRecord::Migration[7.0]
  def change
    add_column :transactions, :active_status, :boolean, default: true
    add_column :transactions, :del_status, :boolean, default: false
  end
end
