require 'stamp/countries'
require 'stamp/phone'
require 'stamp/number'
require 'pp'

module Stamp
  module Params
    class << self
      def build(country_name, service_name, barcode_status = nil, barcode = nil)
        country = country_name.downcase.tr(' ','_')
        method_name = (country_name.downcase.tr(' ','_') + '_' + service_name.downcase.tr(' ','_')).gsub(/[-]/, '_')
        if barcode_status == 'old'
          method_name = method_name + "_old"
        elsif barcode_status == 'new'
          method_name = method_name + "_new"
        end

        method_electricity_rex = /#{country}_.*_electricity_postpay/
        method_new_barcode_rex = /#{country}_.*_postpay_new/

        if method_new_barcode_rex.match(method_name)
          self.send(method_name, barcode)
        elsif self.respond_to?(method_name)
          self.send(method_name)
        elsif method_electricity_rex.match(method_name)
          self.send("#{country}_electricity_postpay")
        else
          self.params(country_name, service_name)
        end
      end 

      def params(country_name, service_name)
        cc = Stamp::Countries.code(country_name)
        { number: Stamp::Phone.for(cc) }
      end

      def dominican_republic_electricity_postpay
        { number: Stamp::Number.random(7)}
      end
      def dominican_republic_wind_bundle_postpay
        { number: Stamp::Phone.for("do")[2..-1]}
      end
      def dominican_republic_wind_cable_postpay
        { number: Stamp::Phone.for("do")[2..-1]}
      end
      def dominican_republic_wind_internet_postpay
        { number: Stamp::Number.random(9)}
      end
      def dominican_republic_tricom_cable_postpay
        { number: Stamp::Phone.for("do")[2..-1]}
      end
      def guatemala_eegsa_electricity_postpay
        { number: Stamp::Number.random(7)}
      end

      def guatemala_energuate_electricity_postpay
        { number: Stamp::Number.random(7, '1000')}
      end
      
      def guatemala_claro_phone_postpay      
        { number: Stamp::Phone.for('gt')}
      end

      def el_salvador_electricity_postpay
        { number: Stamp::Number.random(7)}
      end

      def el_salvador_delsur_electricity_postpay
        { number: "2"+Stamp::Number.random(6)}
      end

      def el_salvador_claro_phone_postpay
        cc = Stamp::Countries.code("El Salvador")       
        { number: Stamp::Phone.for(cc),
            service_type: "Mobile" }
      end

      def el_salvador_digicel_phone_top_up
        cc = Stamp::Countries.code("El Salvador")       
        { number: Stamp::Phone.for(cc)}
      end

      def mexico_gigacable_cable_postpay
        { number: Stamp::Number.random(8)}
      end

      def mexico_gas_natural_fenosa_gas_postpay
        { 
          number: Stamp::Number.random(rand(3..8)),
            region: "Aguascalientes"}
      end

      def mexico_cfe_electricity_postpay
        barcode = Stamp::Barcode.barcode_cfe()
        { barcode: barcode }
      end    
      def mexico_cfe_electricity_postpay_old
        barcode = Stamp::Barcode.barcode_cfe("old")
        { barcode: barcode }
      end

      def mexico_cfe_electricity_postpay_new(barcode)
        { barcode: barcode }
      end

      def mexico_telmex_phone_postpay
        barcode = Stamp::Barcode.barcode_telmex
        number = barcode[0,10]
        number = "+55" + number
        number.insert(3, " ")
        number.insert(5, " ")
        number.insert(9, " ")
        { barcode: barcode,
          number: number }
      end

      def nicaragua_claro_internet_postpay
        cc = Stamp::Countries.code("Nicaragua")  
        number = Stamp::Phone.for(cc)
        { number: number,
            service_type: "Wired" }
      end

      def nicaragua_claro_phone_postpay
        cc = Stamp::Countries.code("Nicaragua")   
        number = Stamp::Phone.for(cc)
        { number: number,
            service_type: "Mobile" }
      end

      def nicaragua_enacal_water_postpay
        cc = Stamp::Countries.code("Nicaragua")    
        { number: Stamp::Number.random(6)}
      end

      def nicaragua_ibw_bundle_postpay
        { number: Stamp::Number.random(9)}
      end

      def nicaragua_ibw_cable_postpay
        { number: Stamp::Number.random(9)}
      end

      def nicaragua_ibw_internet_postpay
        { number: Stamp::Number.random(9)}
      end

      def nicaragua_movistar_phone_postpay
        cc = Stamp::Countries.code("Nicaragua")   
        number = Stamp::Phone.for(cc)
        { number: number,
            service_type: "Mobile" }
      end

      def panama_aseo_waste_postpay
        { number: Stamp::Number.random(6)}
      end

      def panama_cable_onda_bundle_postpay
        { number: Stamp::Number.random(8)}
      end

      def panama_cable_onda_cable_postpay
        { number: Stamp::Number.random(8)}
      end

      def panama_cable_onda_internet_postpay
        { number: Stamp::Number.random(8)}
      end

      def panama_cable_onda_phone_postpay
        cc = Stamp::Countries.code("Panama")   
        number = Stamp::Phone.for(cc)
        { number: number}
      end

      def panama_claro_bundle_postpay
        { number: Stamp::Number.random(10)}
      end

      def panama_claro_cable_postpay
        { number: Stamp::Number.random(5)}
      end

      def panama_claro_internet_postpay
        { number: Stamp::Number.random(10)}
      end


      def panama_claro_phone_postpay
        #num = Stamp::Phone.for("pa")
        num = Stamp::Number.random(10,"628")
       { number: num}
      end

      def panama_sky_cable_postpay
        { number: Stamp::Number.random(12)}
      end

      def panama_ensa_electricity_postpay
        { number: Stamp::Number.random(6)}
      end 

      def panama_gas_natural_fenosa_electricity_postpay
        { number: Stamp::Number.random(10),
            region: "Metro-Oeste" }
      end

      def panama_idaan_water_postpay
        { number: Stamp::Number.random(rand(1..8))}

      end
      def pakistan_uphone_top_up
        { number: Stamp::Phone.for('pk') }
      end
      def honduras_electricity_postpay
        { number: Stamp::Phone.for('hn') }
      end
      def honduras_aguas_de_san_pedro_water_postpay
        { number: Stamp::Number.random(7)}
      end
      def honduras_sanaa_water_postpay
        { number: Stamp::Number.random(10)}
      end
      def honduras_enee_electricity_postpay
        { number: Stamp::Number.random(6)}
      end
    end
  end
end