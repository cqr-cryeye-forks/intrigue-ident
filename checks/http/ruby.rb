module Intrigue
module Ident
module Check
class Ruby < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["library"],
        vendor:"Ruby-Lang",
        product:"Ruby",
        description:"x-rack-cache header",
        match_type: :content_headers,
        match_content:  /^x-rack-cache:.*$/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["library"],
        vendor:"Ruby-Lang",
        product:"Ruby",
        description:"server header",
        match_type: :content_headers,
        dynamic_version: lambda {|d| _first_header_capture(d,/\(Ruby\/([\d\.]+)\/[\d\-]+\)/) },
        match_content:  /server:.*\(Ruby\/[\d\.]+\/[\d\-]+\)/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["library"],
        vendor:"Ruby-Lang",
        product:"Webrick",
        description:"server header",
        match_type: :content_headers,
        dynamic_version: lambda {|d| _first_header_capture(d,/WEBrick\/([\d\.]+)/) },
        match_content:  /server:.*WEBrick\/[\d\.]+/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: true
      }
    ]
  end

end
end
end
end
