#
# Be sure to run `pod lib lint Contlo-iOS-SDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Contlo-iOS-SDK'
  s.version          = '0.0.1-beta'
  s.summary          = 'A short description of Contlo-iOS-SDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/contlo/Contlo-iOS-SDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'AmanContlo' => 'aman.toppo@contlo.com' }
  s.source           = { :git => 'https://github.com/contlo/Contlo-iOS-SDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  # s.swift_version = '5.0'

  s.ios.deployment_target = '11.0'

  s.source_files = 'Contlo-iOS-SDK/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Contlo-iOS-SDK' => ['Contlo-iOS-SDK/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
   s.dependency 'Sentry', '~> 8.14.2'
end
