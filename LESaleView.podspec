#
# Be sure to run `pod lib lint LESaleView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LESaleView"
  s.version          = "0.1.0"
  s.summary          = "Square Sale View"
  s.description      = "LESaleView is a square sale view clone"
  s.homepage         = "https://github.com/efremidze/LESaleView"
  s.license          = 'MIT'
  s.author           = { "Lasha Efremidze" => "efremidzel@hotmail.com" }
  s.source           = { :git => "https://github.com/efremidze/LESaleView.git", :tag => s.version.to_s }
  s.social_media_url = 'http://linkedin.com/in/efremidze'
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'LESaleView/*'
  s.dependency 'XXNibBridge', '~> 2.1'
end
