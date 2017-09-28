#!/usr/bin/env ruby

class Ticket < ActiveRecord::Base
  belongs_to :train
  belongs_to :start_city, class_name: "City", foreign_key: "start_city_id"
  belongs_to :end_city, class_name: "City", foreign_key: "end_city_id"

  validates :train, :start_city, :end_city, presence: true
  validates_each :start_city, :end_city do |record, attr, value|
    record.errors.add(attr, 'must be on train line') unless value.trains.include?(record.train)
  end
  validates_each :end_city do |record, attr, value|
    stops = record.train.stops.order(:departure)
    start_time = nil
    end_time = nil
    stops.each do |stop|
      if stop.city == record.start_city
        start_time = stop.departure
      elsif stop.city == value
        end_time = stop.departure
      end
    end
    if (start_time != nil) & (end_time != nil)
      if start_time > end_time
        record.errors.add(attr, 'must be after start city on train line')
      end
    end
  end

end
