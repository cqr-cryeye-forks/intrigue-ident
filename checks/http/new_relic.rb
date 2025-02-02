module Intrigue
module Ident
module Check
class NewRelic < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "service",
        tags: ["APM","Javascript"],
        vendor: "NewRelic",
        product:"NewRelic",
        references: ["https://discuss.newrelic.com/t/relic-solution-what-is-bam-nr-data-net-new-relic-browser-monitoring/42055"],
        description:"NewRelic tracking code",
        version: nil,
        match_type: :content_body,
        match_content:  /bam.nr-data.net/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
      }
    ]
  end

end
end
end
end
