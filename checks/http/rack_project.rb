module Intrigue
module Ident
module Check
class RackProject < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["WebServer"],
        vendor:"Rack Project",
        product:"Rack",
        description:"x-rack-cache header",
        match_type: :content_headers,
        match_content:  /^x-rack-cache:.*$/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["WebServer"],
        vendor:"Rack Project",
        product:"Rack",
        description:"x-cascade header",
        match_type: :content_headers,
        match_content:  /^x-cascade:.*$/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["WebServer"],
        vendor:"Rack Project",
        references: [
          "https://stackoverflow.com/questions/984633/how-to-remove-x-runtime-header-from-nginx-passenger",
          "https://hackernoon.com/the-giving-ruby-the-strange-case-of-user-enumeration-on-heroku-not-fixed-1a8296067318"
        ],
        product:"Rack",
        description:"x-runtime header",
        match_type: :content_headers,
        match_content:  /^x-runtime:.*$/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }
    ]
  end
  
end
end
end
end