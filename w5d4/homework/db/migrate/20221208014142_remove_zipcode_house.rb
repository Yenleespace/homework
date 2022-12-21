class RemoveZipcodeHouse < ActiveRecord::Migration[7.0]
  def change
    remove_column :houses, :zipcode
  end
end
