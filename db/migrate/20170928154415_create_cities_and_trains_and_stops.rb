class CreateCitiesAndTrainsAndStops < ActiveRecord::Migration[5.1]
  def change
    create_table(:cities) do |t|
      t.column(:name, :string)
      t.timestamps
    end

    create_table(:trains) do |t|
      t.column(:name, :string)
      t.timestamps
    end

    create_table(:stops) do |t|
      t.column(:city_id, :int)
      t.column(:train_id, :int)
      t.column(:departure, :time)
      t.timestamps
    end
  end
end
