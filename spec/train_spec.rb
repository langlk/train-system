#!/usr/bin/env ruby

require 'spec_helper'

describe('Train') do
  describe('#cities') do
    it "returns all cities a train has stops in" do
      city1 = City.create({name: "Seattle"})
      city2 = City.create({name: "Tacoma"})
      train = Train.create({name: "Sounder"})
      train.stops.create({city_id: city1.id})
      train.stops.create({city_id: city2.id})
      expect(train.cities).to eq([city1, city2])
    end
  end
end
