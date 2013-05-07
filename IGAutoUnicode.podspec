Pod::Spec.new do |s|
  s.name = 'IGAutoUnicode'
  s.version = '1.0.0'
  s.license = { :type => 'MIT', :file => 'LICENSE' }
  s.summary = 'Convert string in arbitary encoding to NSString in Objective-C.'
  s.homepage = 'https://github.com/siuying/IGAutoUnicode'
  s.author = { 'Francis Chong' => 'francis@ignition.hk' }
  s.source = { :git => 'https://github.com/siuying/IGAutoUnicode.git', :tag => '1.0.0' }

  s.source_files = 'IGAutoUnicode/*.{h,m}'
  s.dependency 'UniversalDetector'

  s.requires_arc = true
end