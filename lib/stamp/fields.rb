require 'deep_merge'

module Stamp
  module Fields
    class << self
      def for(country_name, service_name, type = :postpay, state = :ready, user = nil)
        fields = base_fields(type, state.to_sym,  user)       
        service_fields(country_name, service_name, type, state, user)
        fields.deep_merge( service_fields(country_name, service_name, type, state, user) )
        fields.deep_merge(mexico_validator(service_name))
        fields.deep_merge(mexico_invoice_validator(fields, service_name, state))
      end
      def mexico_validator(service_name)
        unless (service_name == 'Cfe Electricity Postpay' or service_name == 'Telmex Phone Postpay') 
          {"query" => {"params" => {"number" => ""}}}
        end
      end

      def mexico_invoice_validator(fields, service_name, state)
        if((service_name == 'CFE Electricity Postpay') and (state == 'invoice'))
          fields.delete("query")
          fields.deep_merge({"query" => {"params" => {"barcode" => ""}, "response" => {}}})
        end
      end
   
      def service_fields(country_name, service_name, type, state, user)
        country = country_name.downcase.tr(' ','_')
        method_name = (country + '_' + service_name.downcase.tr(' ','_'))
        method_rex = /#{country}_.*_phone_postpay/

        if type.to_s == "topup"
          case country_name
          when 'Guatemala'
            {}
          when 'El Salvador'
            {}
          when 'Nicaragua'
            {}
          end
        elsif self.respond_to?(method_name)
          self.send(method_name, state)
        elsif method_rex.match(method_name)
          self.send("#{country}_phone_postpay", state)
        elsif self.respond_to?(country)
          self.send(country, state)
        else
          {}
        end

      end
       
      def guatemala_phone_postpay(state = nil)
        guatemala(state).merge({"formatted_number" => /^\+502 \d{4} \d{4}$/})
      end

      def nicaragua_phone_postpay(state = nil)
        nicaragua(state).merge({"formatted_number" => /^\+505 \d{4} \d{4}$/})
      end

      def el_salvador_phone_postpay(state = nil)
        el_salvador(state).deep_merge({"query" => {"params" => {"service_type" => ""}},"formatted_number" => /^\+503 \d{4} \d{4}$/})
      end

      def panama_phone_postpay(state = nil)
        panama(state).merge({"formatted_number" => /^\+507 \d{3}-\d{4}$/})
      end

      def panama_gas_natural_fenosa_electricity_postpay(state = nil)
       if state == 'processed'
          panama(state).merge({"query" => {"params" => {"region" => ""}}})
       else
        {"query" => {"params" => {"region" => ""}}}
       end
      end

      def nicaragua_movistar_phone_postpay(state = nil) 
        nicaragua(state).merge({"formatted_number" => /^\+505 \d{4} \d{4}$/})
      end

      def nicaragua_phone_postpay(state = nil)
        nicaragua(state).deep_merge({"query" => {"params" => {"service_type" => ""}}}).merge({"formatted_number" => /^\+505 \d{4} \d{4}$/})
      end

      def dominican_republic_phone_postpay(state = nil)
        dominican_republic(state).merge({"formatted_number" => /^\+1 809 \d{3} \d{4}$/})
      end

      def mexico_gigacable_cable_postpay(state = nil)
        if state == 'processed'
          {"query" => {"response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}},"payment" => {"response" => {"autorizacion" => "", "folio" => ""}}}
        else
          {"query" => {"response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}}
        end
      end

      def mexico_gas_natural_fenosa_gas_postpay(state = nil)
        if state == 'processed'
           {"query" => {"params" => {"region" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}, "payment" => {"response" => {"autorizacion" => "", "folio" => ""}}}
        else
          {"query" => {"params" => {"region" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}}
        end
      end

      def nicaragua_claro_internet_postpay(state = nil)
        nicaragua(state).deep_merge({"query" => {"params" => {"service_type" => ""}}})
      end

      def mexico_cfe_electricity_postpay(state = nil)
        if state == 'processed'
          {"query" => {"params" => {"barcode" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}, "payment" => {"response" => {"autorizacion" => "", "folio" => ""}}}
        elsif state == 'invoice'
           {"id" => 123, "number" => 123, "service" => {"slug" => "", "url" => "", "category" => ""}, "url" => "", "state" => "", "currency" => "", "query" => {"params" => {"barcode" => ""}}}
        else
          {"query" => {"params" => {"barcode" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}}
        end
      end

      def mexico_telmex_phone_postpay(state = nil)
        if state == 'processed'
          {"query" => {"params" => {"barcode" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}, "payment" => {"response" => {"autorizacion" => "", "folio" => ""}}, "formatted_number" => ""}
        else
          {"query" => {"params" => {"barcode" => ""}, "response" => {"_Ref3" => "", "_cargo" => "", "_comision" => ""}}, "formatted_number" => ""}          
        end
      end

      def panama_claro_phone_postpay(state = nil)
      {}
      end


    

      def guatemala(state = nil)
        {"query" => {"response" => {"_bill" => ""}}}
      end

      def mexico(state = nil)
        {}
      end
      def dominican_republic(state = nil)

        if state == 'processed'
          {"payment" => {"response" => {"payment_ref_no" => ""}}}
        else
         {}
        end
      end

      def el_salvador(state = nil)
        {"query" => {"response" => {"_amount1" => "", "_amount2" => "", "_amount3" => "", "_amt_desc1" => "", "_amt_desc2" => "", "_amt_desc3" => "", "_collector_id" => "", "_collector_ref" => "", "_flg_amount" => ""}}}
      end

      def nicaragua(state = nil)
        {"query" => {"response" => {"_id_pago" => "", "_no_client" => "", "_no_cuenta" => "", "_no_documento" => "", "_no_identificacion" => "", "_telefono" => ""}}}
      end

     def panama(state = nil)  
        if state == 'processed'
         {"payment" => {"response" => {"charge_amount" => "", "client_switch_transaction_date" => "", "client_switch_transaction_id" => "", "commission_amount" => "", "e_pago_transaction_date" => "", "e_pago_transaction_id" => "", "print_references" => "", "tax1_amount" => "", "tax2_amount" => ""}}}
        else
          {"query" => {"response" => ""}}
        end        
     end     
      
      def honduras_aguas_de_san_pedro_water_postpay(state = nil)
        {"query" => {"response" =>{"_amount_due_raw"=>"","_reference_1"=>"","_reference_2"=>"","_reference_4"=>""}}}
      end
      def honduras_sanaa_water_postpay(state = nil)
        {"query" => {"response" =>{"_amount_due_raw"=>"","_reference_1"=>"","_reference_2"=>"","_reference_4"=>""}}}
      end
      def honduras_enee_electricity_postpay(state = nil)
        {"query" => {"response" =>{"_amount_due_raw"=>"","_reference_1"=>"","_reference_2"=>"","_reference_4"=>""}}}
      end
      def base_fields( type = :postpay, state = :ready, user = nil)

        fields = {
          "id" => 123,
          "number" => "",
          "service" => {
            "slug" => "",
            "url" => "",
            "category" => ""
          },
          "url" => "",
          "state" => "",
          "currency" => "",
          "total" => "",
          "total_cents" => 123,
          "query" => {
            "params" => {
              "number" => ""
            },
            "response" => {
            }
          }
        }

        if type == :postpay
          if state == :invoice
            fields["query"] = {}
          else
            fields["query"]["response"] = {
            "name" => "",
            "address" => "",
            "amount_cents" => 123,
            "amount" => ""
          }
          end
        end

        if [:authorized, :processed].include?(state)
          if type == :postpay
            fields["authorization"] = {
              "params" => {
                "code" => "",
                "total_cents" => 123,
                "url"=>""
              },
              "response" => {
                "validity" => 48,
                "message" => "authorized"
              }
            }
          else
            fields["authorization"] = {
              "params" => {
                "code" => "",
                "amount" => "",
                "url"=>""
              },
              "response" => {
                "validity" => 48,
                "message" => "authorized"
              }
            }
          end
        end

        if state == :processed
          fields["payment"] = {
            "params" => {
              "reference"=>"",
              "id"=>"",
              "url"=>""
            },
            "response" => {
              "partner_reference"=>""
            }
          }          
        end

        if user
          fields["provider"] = {
            "handle" => "",
            "gateway_handle" => nil,
            "time_zone" => "",
            "revertable" => true
          }
        end

        fields
      end


    end
  end
end
