require 'deep_merge'
require 'stamp'

module Stamp
  module Account
    class << self

      def create( country_name, service_name, user = nil, barcode_status = nil, options = {})
        params = Stamp::Params.build(country_name, service_name, barcode_status)
        params.deep_merge!(options)

        if user
          options = {
            :headers => {
              'Authorization' => "Bearer #{user["access_token"]}"
            }}
        else
          options = {}
        end
        options[:body] = params

        url = accounts_url(country_name, service_name)
        response = Stamp.post(url, options)
        return response, params
      end

      def modify_by_barcode( country_name, service_name, user = nil, barcode_status, barcode, options)
        params = Stamp::Params.build(country_name, service_name, barcode_status, barcode)
        params.deep_merge!(options)

        if user
          options = {
            :headers => {
              'Authorization' => "Bearer #{user["access_token"]}"
            }}
        else
          options = {}
        end
        options[:body] = params

        url = accounts_url(country_name, service_name)
        response = Stamp.post(url, options)
        return response, params
      end

      def service_slug( service_name )
        service_name.downcase.tr(' ','-')
      end

      def service_url( country_name, service_name)
        cc = Stamp::Countries.code(country_name)
        path = "/v1/services/#{cc}/#{service_slug(service_name)}"
        "#{Stamp.base_url}#{path}"
      end

      def accounts_url( country_name, service_name)
        "#{service_url(country_name, service_name)}/accounts"
      end
    end
  end
end
