#!/usr/bin/env ruby

require 'spec_helper'

describe('Stop') do
  describe '#save' do
    it "does not allow a stop with a nonexistant city" do
      city = City.create({name: 'Seattle'})
      train = Train.create({name: 'Sounder'})
      stop = Stop.new({departure: Time.now, train_id: train.id, city_id: (city.id + 1)})
      expect(stop.save).to eq(false)
    end

    it "does not allow a stop with a nonexistant train" do
      city = City.create({name: 'Seattle'})
      train = Train.create({name: 'Sounder'})
      stop = Stop.new({departure: Time.now, train_id: (train.id + 1), city_id: city.id})
      expect(stop.save).to eq(false)
    end

    it "does not allow a nil Time" do
      city = City.create({name: 'Seattle'})
      train = Train.create({name: 'Sounder'})
      stop = Stop.new({train_id: train.id, city_id: city.id})
      expect(stop.save).to eq(false)
    end
  end

  describe '#train' do
    it "returns the train a stop belongs to" do
      train = Train.create({name: "Sounder"})
      stop = Stop.create({train_id: train.id, departure: Time.now})
      expect(stop.train).to eq(train)
    end
  end
end
