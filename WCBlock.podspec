Pod::Spec.new do |s|
  s.name         = "WCBlock"
  s.version      = "1.0.1"
  s.summary      = "a lightweight block library of UIKit extension"
  s.description  = <<-DESC
                      the library will  make your code more  simple , and you will love it for ever
                   DESC
  s.homepage     = "https://github.com/manakiaHk/WCBlock"
  s.license      = "MIT"
  s.author       = { "manakiaHk" => "weichengz0_0@163.com" }
  s.platform     = :ios
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/manakiaHk/WCBlock.git", :tag => "1.0.1"}
  s.source_files  = "WCBlock/**/*.{h,m}"
 
  # s.public_header_files = "Classes/**/*.h"
  s.requires_arc = true
end