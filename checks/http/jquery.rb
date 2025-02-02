module Intrigue
  module Ident
    module Check
      class Jquery < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: "fingerprint",
              category: "application",
              tags: ["Javascript"],
              website: "https://jquery.com/",
              vendor: "JQuery",
              product: "JQuery",
              description: "version in js file",
              match_type: :content_body,
              match_content: /jQuery v(\d+(\.\d+)*) \| \(c\) JS Foundation and other contributors/i,
              dynamic_version: lambda { |x|
                _first_body_capture(x, /jQuery v(\d+(\.\d+)*) \| \(c\) JS Foundation and other contributors/i)
              },
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["Javascript"],
              website: "https://jquery.com/",
              vendor: "JQuery",
              product: "JQuery",
              description: "script page referece",
              match_type: :content_body,
              version: nil,
              match_content: /script\ src=[\"|\']https:\/\/code\.jquery\.com\/jquery-/i,
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["Javascript"],
              website: "https://jquery.com/",
              vendor: "JQuery",
              product: "Datatables",
              description: "script page referece",
              match_type: :content_body,
              version: nil,
              match_content: /jquery\.dataTables\.min\.js[\"|\']\>/i,
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["Javascript"],
              website: "https://jquery.com/",
              vendor: "JQuery",
              product: "JQuery",
              description: "script page referece",
              match_type: :content_body,
              version: nil,
              match_content: /src=.*?\/jquery-(\d+(\.\d+)*)(?:\.min)?.js/i,
              dynamic_version: lambda { |x| _first_body_capture(x, /src=.*?\/jquery-(\d+(\.\d+)*)(?:\.min)?.js/i) },
              paths: [{ path: "#{url}", follow_redirects: true }],
              inference: true,
            },
          ]
        end
      end
    end
  end
end
