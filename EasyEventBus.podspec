Pod::Spec.new do |spec|

  spec.name         = "EasyEventBus"
  spec.version      = "0.0.1"
  spec.summary      = "A easy evnet bus for iOS"
  spec.description  = "A easy event bus for iOS"
  spec.homepage     = "https://github.com"
  spec.license      = "MIT"
  spec.author             = { "kmqq" => "supermanyqq@163.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/supermanyqq/EasyEventBus.git", :tag => "#{spec.version}" }
  spec.source_files  = "EasyEventBus", "EasyEventBus/**/*.{h,m}"
  spec.exclude_files = "EasyEventBus/Exclude"
  spec.swift_version = "5.0"

end
