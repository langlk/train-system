#!/usr/bin/env ruby

require 'spec_helper'

describe('Train') do
  describe('#save') do
    it "does not allow name to be blank" do
      train = Train.new({name: ''})
      expect(train.save).to eq(false)
    end
  end

  describe('#cities') do
    it "returns all cities a train has stops in" do
      city1 = City.create({name: "Seattle"})
      city2 = City.create({name: "Tacoma"})
      train = Train.create({name: "Sounder"})
      train.stops.create({city_id: city1.id, departure: Time.now})
      train.stops.create({city_id: city2.id, departure: Time.now})
      expect(train.cities).to eq([city1, city2])
    end
  end

  describe('#destroy') do
    it 'destroys all trains stops when train is destroyed' do
      city = City.create({name: "Seattle"})
      train = Train.create({name: "Hogwarts Express"})
      stop = Stop.create({departure: Time.now, city_id: city.id, train_id: train.id})
      train.destroy
      expect(Stop.all).to(eq([]))
    end
  end
end
