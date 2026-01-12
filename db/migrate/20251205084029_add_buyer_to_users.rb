class AddBuyerToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :buyer, :boolean
  end
end
