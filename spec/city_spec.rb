#!/usr/bin/env ruby

require 'spec_helper'

describe('City') do
  describe('#save') do
    it "does not allow a blank name" do
      city = City.new({name: ''})
      expect(city.save).to eq(false)
    end
  end

  describe '#trains' do
    it "returns all trains that stop in a city" do
      city = City.create({name: "Seattle"})
      train1 = city.trains.new({name: "Sounder"})
      train2 = city.trains.new({name: "Amtrak"})
      train1.save
      train2.save
      expect(city.trains).to eq([train1, train2])
    end
  end

  describe('#destroy') do
    it "destroys all stops for that city before deleting" do
      city = City.create({name: "Seattle"})
      train = Train.create({name: "Hogwarts Express"})
      stop = Stop.create({departure: Time.now, city_id: city.id, train_id: train.id})
      city.destroy
      expect(Stop.all).to(eq([]))
    end
  end
end
