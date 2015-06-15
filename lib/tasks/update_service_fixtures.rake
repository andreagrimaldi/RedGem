require 'httparty'
require 'json'
require 'pp'

require 'stamp'
require_relative '../../lib/stamp/params'
require_relative '../../features/support/accounts_helpers'


namespace :services do
  namespace :fixtures do

    desc "Update Service Fixtures"
    task :update do
      host = "#{Stamp.base_url}/v1/services?per_page=1000"
      response = HTTParty.get(host)

      @services = JSON.parse(response.body)

      @services.each do |s|
        country = s["country"]["name"].downcase.tr(' ','-')
        slug = s["slug"]
        fixture_name = country + '-' + slug + '.json'

        service = HTTParty.get(s["url"]).body
                
        puts 'Writing ' + fixture_name
        
        fixture_path = File.expand_path(Dir.pwd) + "/features/support/fixtures/#{fixture_name}"
        File.open(fixture_path, 'w') do |file|
          file << service
        end
      end
      
    end
    
  end
end
namespace :generation_stress_test do

desc "Massive account generation"
  task :create_account do
    service = 'Movistar Phone Top Up'
    150.times do |i|
      fork do
        j = i % 6
        service_name = case j
                              when 0
                                #'Caess Electricity Postpay'
                                service
                              when 1
                                #'Delsur Electricity Postpay'
                                service
                              when 2
                                #'Eeo Electricity Postpay'
                                service
                              when 3
                                #'Clesa Electricity Postpay'
                                service
                              when 4
                                #'Deusem Electricity Postpay'
                                service
                              when 5
                                 #'Claro Phone Postpay'
                                service
                              end
        service_name
        pp service_name
       
        @params = Stamp::Params.build('Nicaragua', service_name)
        pp 'params'
        pp @params

        @options = {
          body: @params
        }
        accounts_url = AccountsHelpers.accounts_url('Nicaragua', service_name)
        @response =  HTTParty.post(accounts_url, @options)
        @headers = @response.headers
        @account  = JSON.parse(@response.body)
        
           pp @account
        
        Kernel.exit!
      end
    end
  end
end
