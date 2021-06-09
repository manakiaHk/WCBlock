Pod::Spec.new do |s|
  s.name         = "WCBlock"
  s.version      = "1.0.3"
  s.summary      = "a lightweight block library of UIKit extension"
  s.description  = <<-DESC
                      the library will  make your code more  simple , and you will love it for ever
                   DESC
  s.homepage     = "https://github.com/manakiaHk/WCBlock"
  s.license      = "MIT"
  s.author       = { "manakiaHk" => "1085415288@qq.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/manakiaHk/WCBlock.git", :tag => s.version }
  s.source_files  = "WCBlock/**/*.{h,m}"
 
  # s.public_header_files = "Classes/**/*.h"
  s.requires_arc = true
end