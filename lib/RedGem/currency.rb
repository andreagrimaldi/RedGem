# -*- coding: utf-8 -*-
require 'countries'

module Stamp
  module Currency
    def self.code(cc)
      country = Country.find_country_by_alpha2(cc)
      country.currency['code']
    end

    def self.symbol(cc)
      country = Country.find_country_by_alpha2(cc)

      symbol = case cc
               when 'ph'
                 '₱'
               when 'pe'
                 'S/.'
               when 'in'
                 '₹'
               else
                 country.currency['symbol']
               end

      symbol
      
    end

  end
end
