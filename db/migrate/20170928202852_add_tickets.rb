class AddTickets < ActiveRecord::Migration[5.1]
  def change
    create_table(:tickets) do |t|
      t.column(:train_id, :integer)
      t.column(:start_city_id, :integer)
      t.column(:end_city_id, :integer)
      t.timestamps
    end
  end
end
