Pod::Spec.new do |s|
  s.name             = 'DSScrollKit'
  s.version          = '0.1.0'
  s.swift_versions   = ['5.7']
  s.summary          = 'ScrollKit is a SwiftUI library that adds powerful scrolling features to SwiftUI, such as offset tracking and sticky scroll header views.'
  s.description      = 'ScrollKit is a SwiftUI library that adds powerful scrolling features to SwiftUI, such as offset tracking and sticky scroll header views. It makes it easy to add cool scroll view features to your SwiftUI apps.'

  s.homepage         = 'https://github.com/danielsaidi/ScrollKit'
  s.license          = { :type => 'NONE', :file => 'LICENSE' }
  s.author           = { 'Daniel Saidi' => 'daniel.saidi@gmail.com' }
  s.source           = { :git => 'https://github.com/danielsaidi/ScrollKit.git', :tag => s.version.to_s }
  
  s.swift_version = '5.7'
  s.ios.deployment_target = '14.0'
  s.tvos.deployment_target = '14.0'
  s.macos.deployment_target = '11'
  
  s.source_files = 'Sources/ScrollKit/**/*.swift'
end
