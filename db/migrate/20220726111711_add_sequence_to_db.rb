class AddSequenceToDb < ActiveRecord::Migration[7.0]
  def change
    execute "CREATE SEQUENCE transaction_seq start 00001"
  end
end
