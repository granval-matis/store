class AddSellerToUsers < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :seller, :boolean
  end
end
