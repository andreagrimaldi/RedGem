module Stamp
  class Service
    attr_reader :name
    
    def initialize(body = {})
      @name = name_from_slug(body["slug"])
    end

  
    private

    def name_from_slug(slug)
      slug.split('-').map { |w| w.capitalize }.join(' ')
    end
    
  end
end
