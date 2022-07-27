class CreateTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.string :uuid
      t.string :customer_id
      t.decimal :amount, :precision => 11, :scale => 2
      t.decimal :output_amount, :precision => 11, :scale => 2
      t.string :amount_currency
      t.string :output_currency

      t.timestamps
    end
  end
end
