module Intrigue
module Ident
module Check
class WordpressWpSuperCache < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["Wordpress Plugin"],
        vendor:"Wordpress",
        product:"WP-Super-Cache",
        references: [
          "https://wordpress.org/plugins/wp-super-cache/",
          "https://www.computerworld.com/article/2907533/over-1-million-wordpress-sites-may-be-affected-by-a-flaw-in-wp-super-cache-plugin.html"
        ],
        description:"generated by string (body)",
        match_type: :content_body,
        match_content:  /Cached page generated by WP-Super-Cache/i,
        version: nil,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        require_product: "Wordpress",
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["Wordpress Plugin"],
        vendor:"Wordpress",
        product:"WP-Super-Cache",
        description:"generated by string (body)",
        match_type: :content_body,
        match_content:  /wp-super-cache/i,
        version: nil,
        paths: [{ path: "#{url}/wp-json", follow_redirects: true } ],
        require_product: "Wordpress",
        inference: false
      }
    ]
  end

end
end
end
end
