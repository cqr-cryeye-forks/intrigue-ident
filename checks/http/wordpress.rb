module Intrigue
  module Ident
    module Check
      class Automattic < Intrigue::Ident::Check::Base
        def generate_checks(url)
          [
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "wordpress wp-includes script load",
              version: nil,
              match_type: :content_body,
              match_content: /src=\"\/wp-includes\/js/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "wordpress wp-themes load",
              version: nil,
              match_type: :content_body,
              match_content: /src=\"\/wp-content\/themes/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "theme-panel load",
              version: nil,
              match_type: :content_body,
              match_content: /class=\"close-theme-panel/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "error loading main page",
              version: nil,
              match_type: :content_title,
              match_content: /^WordPress &rsaquo; Error$/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "error string",
              version: nil,
              match_type: :content_body,
              match_content: /an error occurred while processing this directive\]/i,
              hide: false,
              paths: [{ path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "wordpress test cookie",
              version: nil,
              match_type: :content_cookies,
              match_content: /wordpress_test_cookie=/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "wordpress login page",
              version: nil,
              match_type: :content_body,
              match_content: /class=\"login login-action-login wp-core-ui/i,
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress - generator page reference",
              version: nil,
              match_type: :content_body,
              match_content: /<meta name="generator" content="WordPress/i,
              dynamic_version: lambda { |x|
                _first_body_capture(x, /<meta name="generator" content="WordPress (\d+(\.\d+)*)/i)
              },
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "wp-embed link",
              version: nil,
              match_type: :content_body,
              match_content: /wp-includes\/js\/wp-embed.min.js\?ver=([\d\.]+)\'/i,
              dynamic_version: lambda { |x| _first_body_capture(x, /wp-includes\/js\/wp-embed.min.js\?ver=([\d\.]+)\'/i) },
              hide: false,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "version string",
              version: nil,
              references: ["https://github.com/caffeinewriter/wp-fingerprinter/blob/master/wp-fingerprint.py"],
              match_type: :content_cookies,
              match_content: /Version ([\d\.]+)/i,
              dynamic_version: lambda { |x| _first_generator_capture(x, /Version ([\d\.]+)/i) },
              hide: false,
              require_product: "Wordpress",
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "common link",
              version: nil,
              match_type: :content_body,
              match_content: /src=\'\/wp-includes\/js\/jquery\/jquery-new\.js\'\>/,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "common link",
              version: nil,
              match_type: :content_body,
              match_content: /<link rel='https:\/\/api.w.org\/'/,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS", "SaaS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "unique header for hosted service",
              version: nil,
              match_type: :content_headers,
              match_content: /x-hacker: If you're reading this, you should visit automattic.com/,
              paths: [ { path: "#{url}", follow_redirects: true } ],
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress WP-JSON endpoint",
              version: nil,
              match_type: :content_body,
              match_content: /gmt_offset/,
              paths: [{ path: "#{url}/wp-json", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: false,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.0",
              match_type: :checksum_body,
              match_content: "a306a72ce0f250e5f67132dc6bcb2ccb",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.1",
              match_type: :checksum_body,
              match_content: "4f04728cb4631a553c4266c14b9846aa",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.2",
              match_type: :checksum_body,
              match_content: "25e1e78d5b0c221e98e14c6e8c62084f",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.3",
              match_type: :checksum_body,
              match_content: "83c83d0f0a71bd57c320d93e59991c53",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.5",
              match_type: :checksum_body,
              match_content: "7293453cf0ff5a9a4cfe8cebd5b5a71a",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.6",
              match_type: :checksum_body,
              match_content: "61740709537bd19fb6e03b7e11eb8812",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.7",
              match_type: :checksum_body,
              match_content: "e6bbc53a727f3af003af272fd229b0b2",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.7.1",
              match_type: :checksum_body,
              match_content: "e6bbc53a727f3af003af272fd229b0b2",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
            {
              type: "fingerprint",
              category: "application",
              tags: ["CMS"],
              vendor: "Wordpress",
              product: "Wordpress",
              description: "Wordpress TinyMCE Editor",
              references: ["https://dcid.me/texts/fingerprinting-web-apps.html"],
              version: "2.9.1",
              match_type: :checksum_body,
              match_content: "128e75ed19d49a94a771586bf83265ec",
              paths: [{ path: "#{url}/wp-includes/js/tinymce/tiny_mce.js", follow_redirects: true } ],
              require_product: "Wordpress",
              inference: true,
            },
          ]
        end
      end
    end
  end
end
