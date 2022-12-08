class AddZipcodeToHouse < ActiveRecord::Migration[7.0]
  def change
    add_column :houses, :zipcode, :integer
  end
end
