module Intrigue
  module Ident
  module Check
  class UnitedDomains < Intrigue::Ident::Check::Base
  
    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "service",
          tags: ["Parked"],
          vendor: "United Domains",
          product: "United Domains",
          website: "https://www.uniteddomains.com/",
          version: nil,
          match_type: :content_body,
          match_content:  /^Diese neue Domain wurde im Kundenauftrag registriert\.$/i,
          paths: [ { path: "#{url}", follow_redirects: true } ],
          inference: false
        }
      ]
    end
  end
  end
  end
  end
  