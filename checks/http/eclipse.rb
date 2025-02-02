module Intrigue
module Ident
module Check
  class Eclipse < Intrigue::Ident::Check::Base

    ###
    ### TODO - general case handled, but needs work on a bunch of edge cases
    ###

    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "application",
          tags: ["WebServer"],
          vendor: "Eclipse",
          product:"Jetty",
          description:"server header - with update",
          version: nil,
          match_type: :content_headers,
          match_content:  /^server:.*Jetty\(.*$/i,
          dynamic_version: lambda{|x| 
            _first_header_capture(x,/^server:.*Jetty\(([\w\d\.]*)\.v[\w\d\.\-]*\).*$/i) 
          },
          dynamic_update: lambda{|x| 
            _first_header_capture(x,/^server:.*Jetty\([\w\d\.]*\.v([\w\d\.\-]*)\).*$/i) 
          },
          paths: [ { path: "#{url}", follow_redirects: true } ],
          examples: [
            "server: Jetty(9.3.19.v20170502)", 
            "server: Jetty(9.2.z-SNAPSHOT)"
          ],
          inference: true
        },
        {
          type: "fingerprint",
          category: "application",
          tags: ["WebServer"],
          vendor: "Eclipse",
          product:"Jetty",
          description:"powered by header - with update",
          version: nil,
          match_type: :content_headers,
          match_content:  /^x-powered-by:.*Jetty\(.*$/i,
          dynamic_version: lambda{|x| 
            _first_header_capture(x,/^x-powered-by:.*Jetty\(([\d\.]*)\.v[\w\d\.\-]*\).*$/i) 
          },
          dynamic_update: lambda{|x| 
            _first_header_capture(x,/^x-powered-by:.*Jetty\([\d\.]*\.v([\w\d\.\-]*)\).*$/i) 
          },
          paths: [ { path: "#{url}", follow_redirects: true } ],
          examples: [
            "x-powered-by: Jetty(9.3.19.v20170502)",
            "x-powered-by: Jetty(9.2.z-SNAPSHOT)"
          ],
          inference: true
        }
      ]
    end

  end
end
end
end
