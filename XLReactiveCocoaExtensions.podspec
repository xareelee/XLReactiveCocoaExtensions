Pod::Spec.new do |s|
  s.name         = 'XLReactiveCocoaExtensions'
  s.version      = '3.1.1'
  s.license      = 'MIT'
  s.summary      = 'The missing part of ReactiveCocoa for development'
  s.homepage     = 'https://github.com/xareelee/XLReactiveCocoaExtensions'
  s.authors      = { 'Kang-Yu Xaree Lee' => 'xareelee@gmail.com' }
  s.source       = { :git => "https://github.com/xareelee/XLReactiveCocoaExtensions.git", :tag => s.version.to_s, :submodules =>  true }
  
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.default_subspecs = 'Core'

  s.subspec 'Core' do |ss|
    ss.source_files = 'XLReactiveCocoaExtensions/*.h', 'XLReactiveCocoaExtensions/RACExtensions/*.{h,m}', 'XLReactiveCocoaExtensions/Foundation/*.{h,m}', 'XLReactiveCocoaExtensions/UIKit/*.{h,m}'
    ss.frameworks = 'Foundation', 'UIKit'
    ss.dependency 'ReactiveObjC', '~> 1.0'
  end
  
end
