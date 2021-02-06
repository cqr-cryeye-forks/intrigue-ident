module Intrigue
    module Ident
    module Check
    module Private
    class Twistphp < Intrigue::Ident::Check::Base
    
        def generate_checks(url)
        [
            {
                :type => "fingerprint",
                :category => "application",
                :tags => ["Web Framework"],
                :vendor => "TwistPHP",
                :product => "TwistPHP",
                :website => "http://twistphp.com/",
                :match_details =>"TwistPHP - x-powered-by header",
                :version => nil,
                :match_type => :content_headers,
                :match_content =>  /^x-powered-by: TwistPHP$/i,
                :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
                :inference => false
            },
            {
                :type => "fingerprint",
                :category => "application",
                :tags => ["Web Framework"],
                :vendor => "TwistPHP",
                :product => "TwistPHP",
                :website => "http://twistphp.com/",
                :match_details =>"TwistPHP - twist_session cookie",
                :version => nil,
                :match_type => :content_headers,
                :match_content =>  /twist_session=/i,
                :paths => [ { :path  => "#{url}", :follow_redirects => true } ],
                :inference => false
            }
        ]
        end
    end
    end
    end
    end
    end
    