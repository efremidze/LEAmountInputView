#
# Be sure to run `pod lib lint LEAmountInputView.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "LEAmountInputView"
  s.version          = "0.1.0"
  s.summary          = "Amount Input View (inspired by Square's design)"
  s.description      = "LEAmountInputView is an amount input view inspired by Square's design"
  s.homepage         = "https://github.com/efremidze/LEAmountInputView"
  s.screenshots      = "https://github.com/efremidze/LEAmountInputView/raw/master/Screenshots/example.gif"
  s.license          = 'MIT'
  s.author           = { "Lasha Efremidze" => "efremidzel@hotmail.com" }
  s.source           = { :git => "https://github.com/efremidze/LEAmountInputView.git", :tag => s.version.to_s }
  s.social_media_url = 'http://linkedin.com/in/efremidze'
  s.platform         = :ios, '7.0'
  s.requires_arc     = true
  s.source_files     = 'LEAmountInputView/*.{h,m}'
  s.dependency 'XXNibBridge', '~> 2.1'
end
