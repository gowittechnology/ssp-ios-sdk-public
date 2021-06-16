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
  spec.description  = <<-DESC
                       Secure, reliable ads framework for ios apps
                       DESC

  spec.homepage     = "https://github.com/gowittechnology/ssp-ios-sdk-public"

  spec.license           =  { :type => 'MIT' }

  spec.author             = { "Dogus Yigit Ozcelik" => "dogusyigitozcelik@gmail.com" }


  spec.source            = { :git => "https://github.com/gowittechnology/ssp-ios-sdk-public.git", :tag => spec.version.to_s }


  spec.framework      = 'WebKit'
  spec.swift_version       = '5.0'
  spec.ios.deployment_target = '10.0'
  spec.source_files  = "sspadkit/**/*.{swift}"
  spec.exclude_files = "Classes/Exclude"


end
