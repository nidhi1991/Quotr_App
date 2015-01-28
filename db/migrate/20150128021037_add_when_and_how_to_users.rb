class AddWhenAndHowToUsers < ActiveRecord::Migration
  def change
    add_column :users, :notify_email, :boolean, :default => true
    add_column :users, :notify_text, :boolean, :default => false
    add_column :users, :when_notified, :text
  end
end
