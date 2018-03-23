#
#  Be sure to run `pod spec lint DingBase.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  You can also run `pod spec lint DingBase.podspec --allow-warnings` to ignore warnings.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
	s.name               = "DingBase"
	s.version            = "0.0.1"
	s.summary            = "Base library for Ding! project"
	s.description        = <<-DESC
	CS3217 Software Engineering on Modern Application Platforms
	2018 @ NUS SoC
	Final Project Group 3 - Ding! (base library)
	DESC
	s.homepage           = "https://github.com/cs3217/2018-final-project-group03"
	s.license            = 'MIT'
	s.author             = { "Group 3 @ CS3217 2018" => "cs3217team@gmail.com" }
	s.source             = { :git => "git@github.com:cs3217/2018-final-project-group03.git", :branch => 'master' }
	s.swift_version      = '4.0.3'
	s.social_media_url = 'https://www.facebook.com/groups/cs3217/'
	s.platform           = :ios, '11.2'
	s.source_files       = 'ding-base/Firebase/*.swift', 'ding-base/Models/*.swift'
end
