#!/usr/bin/env ruby

class City < ActiveRecord::Base
  has_many :stops
  has_many :trains, through: :stops
  validates :name, presence: true
  before_destroy :destroy_stops




  private

  def destroy_stops
    self.stops.each do |stop|
      stop.destroy
    end
  end
end
