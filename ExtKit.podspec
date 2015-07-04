Pod::Spec.new do |s|
  s.name         = "ExtKit"
  s.version      = "0.2"
  s.summary      = "ExtKit is fast development tool library"
  s.homepage     = "https://github.com/ydj/ExtKit"
  s.license      = "MIT"
  s.author       = { "YDJ" => "yudejian@163.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/ydj/ExtKit.git", :tag => s.version }
  s.source_files  = "ExtKit/**/*.{h,m}"
  s.requires_arc = true
  s.frameworks = 'Foundation', 'UIKit','ImageIO','Security','libz'
end
