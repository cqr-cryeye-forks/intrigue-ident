module Intrigue
  module Ident
  module Check
    class Hadoop < Intrigue::Ident::Check::Base
  
      def generate_checks(url)
        [
          {
            type: "fingerprint",
            category: "application",
            tags: ["Development", "COTS"],
            vendor:"Hadoop",
            product:"YARN",
            description:"unique body string",
            version: nil,
            match_type: :content_body,
            match_content:  /user\"\>Logged in as: dr\.who\<\/div\>/im,
            paths: [ { path: "#{url}", follow_redirects: true } ],
            inference: false
          },
          {
            type: "fingerprint",
            category: "application",
            tags: ["Development", "COTS"],
            vendor:"Hadoop",
            product:"YARN",
            description:"unique body string",
            version: nil,
            match_type: :content_body,
            match_content:  /root.users.dr_dot_who/i,
            paths: [ { path: "#{url}", follow_redirects: true } ],
            inference: false
          }
        ]
      end
  
    end
  end
  end
  end
  