require 'thor'
require 'pp'
require 'httparty'

$:.unshift(File.expand_path(Dir.pwd) + '/lib')

require 'stamp'
require 'possessive'

class CountryPostPayServicesFeature < Thor
  include Thor::Actions

  def self.source_root
    File.expand_path(Dir.pwd) + '/lib/templates'
  end
  
  desc "generate CountryCode", "Generate Country's Post Pay service feature"
  def generate(country_code)

    user = Stamp.authenticate

    @cc = country_code

    country = Stamp::Countries.name(@cc)
    @country_name = country.possessive
    country_directory = File.expand_path(Dir.pwd) + '/features/' + country.downcase.tr(' ','-')    

    currency = Stamp::Currency.code(@cc)
    services = []

    items = JSON.parse( HTTParty.get(Stamp.services_url(@cc), {:query => {:per_page => 1000}}).body )
    n = items.size
    items.each_with_index do |item, i|
      puts "Generating #{i+1} of #{n}"
      next if item["category"] == 'top-up'

      service = Stamp::Service.new(item)
      @service_name = service.name

      feature_file_name = country.downcase.tr(' ','-') + '-' + item["slug"] + ".feature"
      feature_file = country_directory + '/' + feature_file_name
      template('country-postpay-services.feature.tt', feature_file)
      
    end
  end
end
