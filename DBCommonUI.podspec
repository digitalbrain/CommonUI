#
# Be sure to run `pod lib lint CommonUI.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
    
Pod::Spec.new do |s|
  s.name             = 'DBCommonUI'
  s.version          = '0.1.9.4'
  s.summary          = 'A short description of CommonUI.'
  s.swift_version    = '5.0'

  s.homepage         = 'https://github.com/digitalbrain/CommonUI'
  s.author           = { 'Massimiliano Schinco' => 'digitalbrain@hotmail.it' }
  s.source           = { :git => 'https://github.com/digitalbrain/CommonUI.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'CommonUI/Classes/**/*'
  
  s.resource_bundles = {
      'CommonUI' => ['CommonUI/Assets/*.{png,storyboard}']
   }

end
