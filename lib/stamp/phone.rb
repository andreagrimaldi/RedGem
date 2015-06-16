require 'stamp/number'

module Stamp
  module Phone

    def self.for(cc)

      phone = case cc.to_sym
              when :ar
                phone_number(7, '+54115')
              when :bo
                phone_number(6, '+59164')
              when :br
                phone_number(7, '+55793')
              when :do
                phone_number(6, '+18092')
              when :ec
                phone_number(6, '+59342')
              when :mx
                phone_number(7, '+52591')
              when :ph
                phone_number(6, '+63421')
              when :pe
                phone_number(7, '+5192')
              when :pa
                phone_number(1, '+5076661109')
              when :gt
                phone_number(6, '+50250')
              when :sv
                phone_number(6, '+50322')
              when :ni
                phone_number(6, '24')
              when :in
                phone_number(4,'+917399')
              when :uy
                phone_number(6,'+59826')
              when :pl
                phone_number(7, '+4850')
              when :es
                phone_number(8, '+346')
              when :co
                phone_number(6, '+573104')
              when :cr
                phone_number(6, '+50624')
              when :pk
                phone_number(7, '+92341')
              when :hn
                phone_number(4, '+5042200')
              when :jm
                phone_number(2,'+187692345')
              when :cl
                phone_number(6,'+56512')
              when :lk
                phone_number(7,'+9471')
              when :cl
                phone_number(6, '+56512')
              else
                raise 'Not a valid country name'
              end

      phone
    end
    def self.carrier_number(cc)
      phone = case cc.to_sym
      #when :ar
      #  phone_number(7, '+54115')
        when :bo
          phone_number(6, '+59175')#
        when :br
          phone_number(7, '+551199')#
        when :do
          phone_number(6, '+18094')#
        when :ec
          phone_number(7, '+59399')#
        when :mx
          phone_number(8, '+52155')#
        when :ph
          phone_number(7, '+63917')#
        when :pe
          phone_number(6, '+51959')#
        when :pa
          phone_number(6, '+50766')#
        when :gt
          phone_number(6, '+50252')#
        when :sv
          phone_number(6, '+50375')#
        when :ni
          phone_number(6, '+50582')#
        when :in
          phone_number(7,'+91986')#
        when :uy
          phone_number(6,'+59895')#
        when :pl
          phone_number(6, '+48505')#
        when :es
          phone_number(6, '+34607')#
        when :co
          phone_number(6, '+573104')#
        when :cr
          phone_number(6, '+50660')#
        when :pk
          phone_number(7, '+92331')#
        when :hn
          phone_number(4, '+5047500')#
        when :jm
          phone_number(2,'+187632345')#
        when :cl
          phone_number(6,'+56973')#
        when :lk
          phone_number(6,'+94712')#
        else
          raise 'Not a valid country name'
      end
      phone
    end

    def self.phone_number(size = 8, prefix = nil)
      number = Stamp::Number.random(size)
      number = prefix + number if prefix
      number
    end

    def self.regex_panama

    end

  end

end
