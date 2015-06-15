module Stamp
  module AuthorizationForm
    def self.create( user, account )
      cc = account["service"]["url"].split('/')[5]
      url = "#{Stamp.base_url}/v1/authorizations/form"
      
      options = {
        :headers => {
          'Authorization' => "Bearer #{user["access_token"]}"
        },
        :body => {
          "country[code]" => cc,
          "service[slug]" => account["service"]["slug"],
          "account[id]"   => account["id"],
        }
      }
      @response = HTTParty.post(url, options)

    end
  end
end
