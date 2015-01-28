class CreateUserQuotes < ActiveRecord::Migration
  def change
    create_table :user_quotes do |t|
      t.integer :user_id
      t.integer :quote_id

      t.timestamps null: false
    end
  end
end
