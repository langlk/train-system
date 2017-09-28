class UpdateDepartureColumnType < ActiveRecord::Migration[5.1]
  def change
    remove_column :stops, :departure
    add_column :stops, :departure, :datetime
  end
end
