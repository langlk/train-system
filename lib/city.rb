#!/usr/bin/env ruby

class City < ActiveRecord::Base
  has_many :stops
  has_many :trains, through: :stops
end
