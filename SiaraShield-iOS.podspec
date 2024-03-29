#
# Be sure to run `pod lib lint SiaraShield-iOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SiaraShield-iOS'
  s.version          = '2.1.2'
  s.summary          = 'A small framework for verification'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  A small framework for verification and related api call
                       DESC

  s.homepage         = 'https://github.com/Shital05Jadav/SiaraShield-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Shital Jadav' => 'shineinfosoft24@gmail.com' }
  s.source           = { :git => 'https://github.com/Shital05Jadav/SiaraShield-iOS.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '12.0'
  s.source_files = 'SiaraShield-iOS/**/*.{h,m,swift,xib,xcassets,gif}'
  s.resources = 'SiaraShield-iOS/**/*.{xcassets}'

 s.resource_bundles = {
    'SiaraShield-iOS' => 'SiaraShield-iOS/**/*'
  }
   s.frameworks = 'UIKit'
   s.swift_versions = '5.0'
end
