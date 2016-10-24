Pod::Spec.new do |s|
  s.name         = 'XLReactiveCocoaExtensions'
  s.version      = '3.0.0'
  s.license      = 'MIT'
  s.summary      = 'The missing part of ReactiveCocoa for development'
  s.homepage     = 'https://github.com/xareelee/XLReactiveCocoaExtensions'
  s.authors      = { 'Kang-Yu Xaree Lee' => 'xareelee@gmail.com' }
  s.source       = { :git => "https://github.com/xareelee/XLReactiveCocoaExtensions.git", :tag => s.version.to_s, :submodules =>  true }
  
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.default_subspecs = 'Core', 'Foundation', 'UIKit'

  s.subspec 'Core' do |ss|
    ss.source_files = 'XLReactiveCocoaExtensions/*.h', 'XLReactiveCocoaExtensions/RACExtensions/*.{h,m}'
    ss.dependency 'ReactiveObjC', '~> 1.0'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'XLReactiveCocoaExtensions/Foundation/*.{h,m}'
    ss.frameworks = 'Foundation'
    ss.dependency 'XLReactiveCocoaExtensions/Core'
  end

  s.subspec 'UIKit' do |ss|
    ss.source_files = 'XLReactiveCocoaExtensions/UIKit/*.{h,m}'
    ss.frameworks = 'UIKit'
    ss.dependency 'XLReactiveCocoaExtensions/Core'
  end

end
