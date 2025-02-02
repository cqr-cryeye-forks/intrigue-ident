module Intrigue
  module Ident
  module Check
  class Symfony < Intrigue::Ident::Check::Base
  
    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "application",
          tags: ["Web Framework"],
          vendor: "Symfony",
          product: "Symfony",
          description: "symfony cookie",
          version: nil,
          match_type: :content_cookies,
          match_content:  /symfony=/i,
          paths: [ { path: "#{url}", follow_redirects: true } ],
          inference: false
        }
      ]
    end
  
  end
  end
  end
  end
  