#!/usr/bin/env ruby

class Stop < ActiveRecord::Base
  belongs_to :city
  belongs_to :train
  validates :city, :train, :departure, presence: true
end
