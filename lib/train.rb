#!/usr/bin/env ruby

class Train < ActiveRecord::Base
  has_many :stops
  has_many :cities, through: :stops
  validates :name, presence: true
end
