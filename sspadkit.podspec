#
#  Be sure to run `pod spec lint sspadkit.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|


  spec.name         = "sspadkit"
  spec.version      = "1.0.0"
  spec.summary      = "banner and popup ads"
  spec.homepage     = "https://github.com/gowittechnology/ssp-ios-sdk-public"
  spec.description  = <<-DESC
                       Secure, reliable ads framework for ios apps
                       DESC


  spec.author             = { "Dogus Yigit Ozcelik" => "dogusyigitozcelik@gmail.com" }
  spec.license           =  { :type => "MIT", :text => "MIT License" }


  spec.platform          = :ios
  spec.source            = { :http => "https://github.com/gowittechnology/ssp-ios-sdk-public/sspadkit.xcframework.zip" }
  
  spec.ios.deployment_target = '10.0'
  spec.ios.vendored_frameworks = 'sspadkit.xcframework'

  spec.framework      = 'WebKit'
  spec.swift_version       = '5.0'
  #spec.source_files  = "sspadkit/"
  #spec.exclude_files = "sspadkit/Private/*.{swift}"

  #spec.exclude_files = "Classes/Exclude"

end
