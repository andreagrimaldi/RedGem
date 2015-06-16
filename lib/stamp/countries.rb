# -*- coding: utf-8 -*-
require 'iso_country_codes'
require 'countries'

module Stamp
  module Countries
    def self.code(country_name) 
      IsoCountryCodes.search_by_name(country_name).first.alpha2.downcase
    end

    def self.name(cc)
      country = Country.find_country_by_alpha2(cc)
      country.name
    end

  end
end
