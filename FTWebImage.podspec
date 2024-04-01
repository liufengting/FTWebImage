Pod::Spec.new do |s|

  s.name         = "FTWebImage"
  s.version      = "0.0.1"
  s.summary      = "FTWebImage"
  s.description  = <<-DESC
          `FTWebImage` is a swift web image downloader, with cache support.
                   DESC
  s.author       = { "liufengting" => "wo157121900@me.com" }
  s.homepage     = "https://github.com/liufengting/FTWebImage"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/liufengting/FTWebImage.git", :tag => "#{s.version}" }
  s.source_files = ["FTWebImage/*"]
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  s.requires_arc = true
  s.swift_version = '5.0'

end
