require "spec_helper"

describe('Ticket') do
  it "does not allow a start and end city that are not on the same train line" do
    city1 = City.create({name: "Seattle"})
    city2 = City.create({name: "Tacoma"})
    city3 = City.create({name: "New York"})
    train = Train.create({name: "Sounder"})
    Stop.create({departure: Time.now, city_id: city1.id, train_id: train.id})
    Stop.create({departure: (Time.now + (60*60)), city_id: city2.id, train_id: train.id})
    ticket = Ticket.new({train_id: train.id, start_city_id: city1.id, end_city_id: city3.id})
    expect(ticket.save).to eq(false)
  end

  it "does not allow an end city that comes before the start city on the train line" do
    city1 = City.create({name: "Seattle"})
    city2 = City.create({name: "Tacoma"})
    city3 = City.create({name: "Lakewood"})
    train = Train.create({name: "Sounder Southbound"})
    Stop.create({departure: Time.now, city_id: city1.id, train_id: train.id})
    Stop.create({departure: (Time.now + (60*60)), city_id: city2.id, train_id: train.id})
    Stop.create({departure: (Time.now + (60*60*2)), city_id: city3.id, train_id: train.id})
    ticket = Ticket.new({train_id: train.id, start_city_id: city2.id, end_city_id: city1.id})
    expect(ticket.save).to eq(false)
  end
end
