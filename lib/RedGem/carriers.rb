module Stamp
  module Carriers
    class << self
     def carrier_fields
        fields = each_carrier_fields()       
        #service_fields(country_name, service_name, type, state, user)
        #fields.deep_merge( service_fields(country_name, service_name, type, state, user) )
      end
           def each_carrier_fields()

      fields = {
          "params"=> {
          "action"=> "",
          "number"=> ""
        },
        "response"=> {
          "service_slug"=> "",
          "country_code"=> "",
          "raw"=> {
            "country"=> "",
            "countryid"=> 123,
            "operator"=> "",
            "operatorid"=> 123,
            "connection_status"=> 123,
            "destination_msisdn"=> 123,
            "destination_currency"=> "",
            "authentication_key"=> "",
            "error_code"=> 123,
            "error_txt"=> ""
          }
        }
      }
      fields
      end
    end
  end
end
