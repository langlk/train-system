#!/usr/bin/env ruby

class Train < ActiveRecord::Base
  has_many :stops
  has_many :cities, through: :stops
  validates :name, presence: true
  before_destroy :destroy_stops

  private

  def destroy_stops
    self.stops.each do |stop|
      stop.destroy
    end
  end
end
