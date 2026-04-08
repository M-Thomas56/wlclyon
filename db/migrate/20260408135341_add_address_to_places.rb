class AddAddressToPlaces < ActiveRecord::Migration[8.1]
  def change
    add_column :places, :address, :string
  end
end
