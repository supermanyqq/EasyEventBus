Pod::Spec.new do |spec|

  spec.name         = "EasyEventBus"
  spec.version      = "0.0.3"
  spec.summary      = "A publish/subscribe EventBus for iOS"
#  spec.description  = "A publish/subscribe EventBus for iOS"
  spec.homepage     = "https://github.com/supermanyqq/EasyEventBus"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "kmqq" => "supermanyqq@163.com" }
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/supermanyqq/EasyEventBus.git", :tag => "#{spec.version}" }
  spec.source_files  = "EasyEventBus", "EasyEventBus/**/*.{h,m}"
  spec.exclude_files = "EasyEventBus/Exclude"
  spec.swift_version = "5.0"

end
