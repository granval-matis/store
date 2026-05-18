class AddMetadataToProducts < ActiveRecord::Migration[8.0]
  def change
    add_column :products, :metadata, :json
  end
end
