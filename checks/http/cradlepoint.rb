module Intrigue
module Ident
module Check
class Cerberus < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["WebServer"],
        vendor: "Cradlepoint",
        product:"HTTP Service",
        description:"server header",
        version: nil,
        match_type: :content_headers,
        match_content:  /^server:.*Cerberus.*$/,
        dynamic_version: lambda{ |x| 
          _first_header_capture(x,/^server:.*Cerberus\/([\d\.]*)\s.*$/i) 
        },
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end

end
end
end
end
