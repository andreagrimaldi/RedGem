require 'httparty'
require 'stamp/account_top_up'
require 'stamp/authorization_form'
require 'stamp/countries'
require 'stamp/currency'
require 'stamp/fields'
require 'stamp/carriers'
require 'stamp/number'
require 'stamp/params'
require 'stamp/phone'
require 'stamp/service'
require 'stamp/account'

module Stamp
  
  def self.env
    ENV['STAMP_ENV'] || 'qa'
  end

  def self.protocol
    if self.env == 'qa'
      'http'
    else
      'https'
    end
  end
  
  def self.base_url
    ENV['STAMP_HOST'] || "#{self.protocol}://api.#{self.env}.bluekite.com"
  end

  def self.oauth_url
    host = ENV['OAUTH_HOST'] || "https://oauth.sandbox.bluekite.com"
    host += "/oauth/access-token"
    host
  end

  def self.oauth_token
    'YzUzMGYzM2I3YzZiNzQzYzI5Yjk5NWE1OWRiZjk1NTc0YTY3NTAxOTo2MjZhNTcwY2JmYjU3M2YxOTg0ZTJiOGFlOTg2MWE4NDAwMjhhZWUy'
  end

  def self.services_url(cc = nil)
    "#{self.base_url}/v1/services" + ( cc ? "/#{cc}" : '')    
  end

  def self.country_url(cc)
    "#{self.base_url}/v1/countries/#{cc}"
  end

  def self.authenticate
    options = {
      headers: {
        'Authorization' => "Basic #{Stamp.oauth_token}"
      },
      body: {
        scope: 'make-authorizations',
        grant_type: 'password',
        username: 'andrea.grimadi@xoom.com',
        password: 'shute456'
      },
      verify: false
    }
    
    JSON.parse(HTTParty.post(Stamp.oauth_url, options).body)
  end

  def self.post(url, options = {})
    opts = options.merge({:follow_redirects => false})
    r = HTTParty.post(url, opts)
    if r.code == 301
      r = self.get(r.headers["location"])
    end
    r
  end

  def self.put(url, options = {})
    opts = options.merge({:follow_redirects => false})
    r = HTTParty.put(url, opts)
    if r.code == 301
      r = self.get(r.headers["location"])
    end
    r
  end

  def self.get(url, options = {})
    HTTParty.get(url, options)
  end
  
end
