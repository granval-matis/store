class AddCommentsToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :comments, :string
  end
end
