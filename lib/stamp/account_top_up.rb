module Stamp
  module AccountTopUp
    def self.create( service )
      cc = service["url"].split('/')[5]
      phone = Stamp::Phone.for(cc)
      accounts_url = service["accounts"]["url"]
      response = HTTParty.post(accounts_url, {:body => {:number => phone}}).body
      JSON.parse( response )      
    end
  end
end
