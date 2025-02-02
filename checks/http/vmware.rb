module Intrigue
module Ident
module Check
class Vmware < Intrigue::Ident::Check::Base

  def generate_checks(url)
    [
      {
        type: "fingerprint",
        category: "application",
        tags: ["Hypervisor"],
        vendor: "VMware",
        product:"ESXi",
        description:"unique page string",
        version: nil,
        match_type: :content_body,
        match_content: /document.write\(\"<title>\"\ \+\ ID_EESX_Welcome/,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false, 
        issue: "exposed_admin_panel_unauthenticated"
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["Hypervisor"],
        vendor: "VMware",
        product:"ESXi",
        description:"unique page string",
        version: nil,
        match_type: :content_body,
        match_content: /client\/VMware-viclient\.exe/i,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["Hypervisor"],
        vendor: "VMware",
        product:"Horizon View",
        description:"page title",
        version: nil,
        match_type: :content_body,
        match_content:  /<title>VMware Horizon/,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      },
      {
        type: "fingerprint",
        category: "application",
        tags: ["Hypervisor"],
        vendor: "VMware",
        product:"vSphere",
        description:"page title",
        version: nil,
        match_type: :content_body,
        match_content:  /document.write\(\"<title>\"\ \+\ ID_VC_Welcome/,
        paths: [ { path: "#{url}", follow_redirects: true } ],
        inference: false
      }
    ]
  end

end
end
end
end
