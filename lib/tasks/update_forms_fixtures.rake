require 'httparty'
require 'json'

namespace :forms do
  namespace :fixtures do

    desc "Update Service Fixtures"
    task :update do
      host = "#{Stamp.base_url}/v1/services?per_page=1000"
      response = HTTParty.get(host)
      services = JSON.parse(response.body)

      services.each do |service|
        country = service["country"]["name"].downcase.tr(' ','-')
        slug = service["slug"]
        fixture_name = country + '-' + slug + '-form.json'

        form = HTTParty.get(service["accounts"]["form_url"]).body
                
        puts 'Writing ' + fixture_name
        
        fixture_path = File.expand_path(Dir.pwd) + "/features/support/fixtures/#{fixture_name}"
        File.open(fixture_path, 'w') do |file|
          file << form
        end
      end
      
    end
    
  end
end
