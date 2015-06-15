module Stamp
  module Barcode
	def self.random(size = 10, prefix = nil)
      number = nil
      size = size - prefix.length if prefix
      number = rand( "".center(size, '9').to_i  ).to_s.center(size, rand(9).to_s)
      "#{prefix}#{number}"
    end

  	def self.barcode_cfe
      prefix = "01"
      service_account = self.random(12)
      today = Date.today + 30
      amount = self.random(9)
      "#{prefix}#{service_account}" + today.year.to_s[-2,2] + fix_date(today.mon) + fix_date(today.day).to_s + "#{amount}" + "0"
    end

    def self.fix_date(date_string)
      if (date_string < 10)
        date_string = "0".concat(date_string.to_s)
      end
      date_string
    end
  end
 end
