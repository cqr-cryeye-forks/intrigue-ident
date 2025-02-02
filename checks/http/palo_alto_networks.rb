require 'time'

module Intrigue
module Ident
module Check
class PaloAltoNetworks < Intrigue::Ident::Check::Base

  def generate_checks(uri)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["Networking", "VPN", "Firewall"],
        vendor: "PaloAltoNetworks",
        product:"GlobalProtect",
        description: "login page string",
        version: nil,
        match_type: :content_body,
        match_content:  /global-protect\/login.esp/i,
        paths: [ { path: "#{uri}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["Networking", "VPN", "Firewall"],
        vendor: "PaloAltoNetworks",
        product:"GlobalProtect", 
        description:"getting last-modified header",
        version: nil,
        match_type: :content_headers,
        match_content: /Last-Modified/i,
        require_product: "GlobalProtect",
        paths: [
          { path: "#{uri}/global-protect/login.esp", follow_redirects: false },
          { path: "#{uri}/global-protect/portal/css/login.css", follow_redirects: true },
          { path: "#{uri}/global-protect/portal/images/favicon.ico", follow_redirects: true },
          { path: "#{uri}/global-protect/portal/images/logo-pan-48525a.svg", follow_redirects: true },
          { path: "#{uri}/login/images/favicon.ico", follow_redirects: true },
          { path: "#{uri}/js/Pan.js", follow_redirects: true }
        ],
        #require_product: "GlobalProtect",
        dynamic_version: lambda { |x|
          date_string = _first_header_capture(x,/Last-Modified:\ (.*)$/i)
          version, approximate = get_pan_version_from_date(date_string) if date_string
        version },
        inference: true
      }
    ]
  end

  
  def get_pan_version_from_date(date_string)
    
    # parse our date string
    begin 
      our_date = Time.parse(date_string)
      our_date = Time.new(our_date.year, our_date.month, our_date.day, 0, 0, 0, our_date.zone)
    rescue ArgumentError => e
      return ["Unknown-Invalid-Version", true]
    end    
    
    # get the first date that's higher or equiv
    matching_key = pan_version_table.keys.sort.select{|x| x >= our_date }.first
    
    if matching_key 
      version = pan_version_table[matching_key]
      approximate = (matching_key > our_date) ? true : false
    else
      return ["Unknown-Recent-Version", true]
    end

  [version, approximate]
  end

  def pan_version_table
    data = '6.0.0,Dec,23,2013
    6.0.1,Feb,26,2014
    6.0.2,Apr,18,2014
    6.0.3,May,29,2014
    6.0.4,Jul,30,2014
    6.0.5,Sep,4,2014
    6.0.5-h3,Oct,7,2014
    6.0.6,Oct,7,2014
    6.0.7,Nov,18,2014
    6.0.8,Jan,13,2015
    6.0.9,Feb,27,2015
    6.0.10,Apr,22,2015
    6.0.11,Aug,12,2015
    6.0.12,Nov,19,2015
    6.0.13,Feb,13,2016
    6.0.14,Jun,28,2016
    6.0.15,Oct,5,2016
    6.1.0,Oct,17,2014
    6.1.1,Nov,13,2014
    6.1.2,Jan,23,2015
    6.1.3,Mar,10,2015
    6.1.4,Apr,22,2015
    6.1.5,Jun,17,2015
    6.1.6,Jul,23,2015
    6.1.7,Sep,10,2015
    6.1.8,Nov,4,2015
    6.1.9,Jan,8,2016
    6.1.10,Feb,12,2016
    6.1.11,Apr,2,2016
    6.1.12,May,21,2016
    6.1.13,Jul,15,2016
    6.1.14,Aug,10,2016
    6.1.15,Oct,5,2016
    6.1.16,Jan,10,2017
    6.1.17,Apr,14,2017
    6.1.18,Jul,14,2017
    6.1.19,Nov,5,2017
    6.1.20,Feb,13,2018
    6.1.21,May,25,2018
    6.1.22,Oct,15,2018
    7.0.1,Jul,3,2015
    7.0.2,Aug,21,2015
    7.0.3,Oct,8,2015
    7.0.4,Dec,12,2015
    7.0.5,Jan,30,2016
    7.0.5-h2,Feb,17,2016
    7.0.6,Mar,12,2016
    7.0.7,Apr,19,2016
    7.0.8,Jun,11,2016
    7.0.9,Jul,27,2016
    7.0.10,Aug,29,2016
    7.0.11,Oct,20,2016
    7.0.12,Dec,6,2016
    7.0.13,Dec,29,2016
    7.0.14,Feb,8,2017
    7.0.15,Apr,12,2017
    7.0.16,May,30,2017
    7.0.17,Jul,10,2017
    7.0.18,Aug,16,2017
    7.0.19,Nov,10,2017
    7.1.0,Mar,16,2016
    7.1.1,Apr,6,2016
    7.1.2,May,3,2016
    7.1.3,Jun,21,2016
    7.1.4,Aug,2,2016
    7.1.4-h2,Aug,12,2016
    7.1.5,Sep,24,2016
    7.1.6,Nov,9,2016
    7.1.7,Dec,17,2016
    7.1.8,Feb,14,2017
    7.1.9,Mar,27,2017
    7.1.9-h4,Jun,16,2017
    7.1.10,May,5,2017
    7.1.11,Jun,29,2017
    7.1.12,Aug,18,2017
    7.1.13,Sep,28,2017
    7.1.14,Nov,13,2017
    7.1.15,Jan,5,2018
    7.1.16,Feb,20,2018
    7.1.17,Apr,11,2018
    7.1.18,Jun,6,2018
    7.1.19,Jul,16,2018
    7.1.20,Sep,7,2018
    7.1.21,Oct,31,2018
    7.1.22,Dec,17,2018
    7.1.23,Mar,9,2019
    7.1.24,Jun,14,2019
    7.1.24-h1,Aug,15,2019
    7.1.25,Aug,30,2019
    7.1.26,Apr,21,2020
    8.0.0,Jan,25,2017
    8.0.1,Mar,9,2017
    8.0.2,Apr,25,2017
    8.0.3,Jun,8,2017
    8.0.3-h4,Jun,22,2017
    8.0.4,Jul,21,2017
    8.0.5,Sep,10,2017
    8.0.6,Nov,4,2017
    8.0.6-h3,Nov,16,2017
    8.0.7,Dec,24,2017
    8.0.8,Jan,31,2018
    8.0.9,Mar,23,2018
    8.0.10,May,4,2018
    8.0.11-h1,Jun,29,2018
    8.0.12,Aug,4,2018
    8.0.13,Sep,18,2018
    8.0.14,Nov,17,2018
    8.0.15,Dec,8,2018
    8.0.16,Feb,12,2019
    8.0.17,Mar,22,2019
    8.0.18,May,13,2019
    8.0.19,Jun,20,2019
    8.0.19-h1,Aug,15,2019
    8.0.20,Oct,18,2019
    8.1.0,Mar,1,2018
    8.1.1,Apr,23,2018
    8.1.2,Jun,6,2018
    8.1.3,Aug,8,2018
    8.1.4,Oct,5,2018
    8.1.5,Nov,21,2018
    8.1.6,Jan,17,2019
    8.1.6-h2,Jan,23,2019
    8.1.7,Mar,13,2019
    8.1.8,Apr,30,2019
    8.1.8-h5,Jun,17,2019
    8.1.9,Jul,3,2019
    8.1.9-h4,Aug,15,2019
    8.1.10,Aug,21,2019
    8.1.11,Oct,12,2019
    8.1.12,Dec,10,2019
    8.1.13,Jan,25,2020
    8.1.14,Apr,1,2020
    8.1.14-h2,Apr,18,2020
    8.1.15,Jun,13,2020
    8.1.16,Aug,12,2020
    8.1.17,Sep,23,2020
    8.1.18,Nov,17,2020
    9.0.0,Jan,29,2019
    9.0.1,Mar,26,2019
    9.0.2,May,7,2019
    9.0.2-h4,Jun,21,2019
    9.0.3,Jul,10,2019
    9.0.3-h2,Jul,18,2019
    9.0.3-h3,Aug,14,2019
    9.0.4,Sep,10,2019
    9.0.5,Nov,7,2019
    9.0.6,Jan,24,2020
    9.0.7,Mar,13,2020
    9.0.8,Apr,7,2020
    9.0.9,Jun,20,2020
    9.0.10,Aug,20,2020
    9.0.11,Oct,7,2020
    9.0.12,Nov,24,2020
    9.1.0,Dec,11,2019
    9.1.0-h3,Dec,21,2019
    9.1.1,Jan,24,2020
    9.1.2,Mar,30,2020
    9.1.2-h1,Apr,9,2020
    9.1.3,Jun,20,2020
    9.1.3-h1,Jun,26,2020
    9.1.4,Jul,27,2020
    9.1.5,Sep,16,2020
    9.1.6,Oct,23,2020
    9.1.7,Dec,15,2020
    10.0.0,Jul,16,2020
    10.0.1,Aug,28,2020
    10.0.2,Oct,27,2020
    10.0.3,Dec,7,2020'
    out = {} 
    data.split("\n").each do |item|
      item = item.split(",")
      date = Time.parse("#{item[1]},#{item[2]},#{item[3]}")
      out[date] = item[0].strip
    end
  out
  end

end
end
end
end
