#!/usr/bin/env ruby

require 'spec_helper'

describe('City') do
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
end
