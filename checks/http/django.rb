module Intrigue
module Ident
module Check
  class Django < Intrigue::Ident::Check::Base

    def generate_checks(url)
      [
        {
          type: "fingerprint",
          category: "application",
          tags: ["Application Server"],
          vendor: "Django",
          product:"Django",
          version: nil,
          description:"Django Admin Page",
          match_type: :content_body,
          match_content:  /Django site admin/,
          paths: [{ path: "#{url}/admin", follow_redirects: true } ],
          inference: false
        }
      ]
    end

  end
end
end
end
