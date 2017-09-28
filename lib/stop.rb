#!/usr/bin/env ruby

class Stop < ActiveRecord::Base
  belongs_to :city
  belongs_to :train
  validates :city, :train, :departure, presence: true

  def departure_pst
    self.departure.utc.localtime('-07:00')
  end
end
