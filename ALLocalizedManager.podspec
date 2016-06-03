Pod::Spec.new do |s|

  s.name         = "ALLocalizedManager"
  s.version      = "0.9.4"
  s.summary      = "Manager for localizable strings"
  s.homepage     = "https://github.com/alobanov/ALLocalizedManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alexey Lobanov" => "lobanov.aw@gmail.com" }
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/alobanov/ALLocalizedManager.git" }
  s.source_files = "ALLocalizedManager/*.{h,m}"
  s.public_header_files = "ALLocalizedManager/*.{h}"
  s.framework    = "UIKit"
  s.requires_arc = true

end
