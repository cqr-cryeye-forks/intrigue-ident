module Intrigue
module Ident
module Check
class Squarespace < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["SaaS", "CMS"],
        vendor: "Squarespace",
        product: "Squarespace",
        description: "server header",
        version: nil,
        match_type: :content_headers,
        match_content:  /^Server: Squarespace$/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "service",
        tags: ["SaaS", "CMS"],
        vendor: "Squarespace",
        product: "Squarespace",
        description: "squarespace missing page",
        version: nil,
        match_type: :content_body,
        match_content:  /<h1>400 Bad Request<\/h1>[\n\s]+<p id=\"status-page\">/im,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false,
        hide: true
      }
    ]
  end

end
end
end
end
