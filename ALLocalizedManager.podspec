Pod::Spec.new do |s|

  s.name         = "ALLocalizedManager"
  s.version      = "1.0.1"
  s.summary      = "Manager for localizable strings"
  s.homepage     = "https://github.com/alobanov/ALLocalizedManager"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Alexey Lobanov" => "lobanov.aw@gmail.com" }
  s.platform     = :ios, "8.0"
  s.ios.deployment_target = '8.0'
  s.social_media_url      = "https://twitter.com/alobanov"

  s.source       = { :git => "git@github.com:alobanov/ALLocalizedManager.git", :tag => s.version.to_s }
  s.source_files = "ALLocalizedManager/*.{h,m}"
  s.framework    = "UIKit"
  s.requires_arc = true
  
  s.dependency 'TTTLocalizedPluralString'

end
