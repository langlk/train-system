#!/usr/bin/env ruby

require 'spec_helper'

describe('Stop') do
  describe '#train' do
    it "returns the train a stop belongs to" do
      train = Train.create({name: "Sounder"})
      stop = Stop.create({train_id: train.id, departure: Time.now})
      expect(stop.train).to eq(train)
    end
  end
end
