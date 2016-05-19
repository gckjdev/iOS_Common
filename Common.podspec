

Pod::Spec.new do |s|
  s.name             = "Common"
  s.version          = "0.1.5"
  s.summary          = "I am a Library"

  s.description      = "A Common Library For Win"
  s.platform           = :ios,'8.0'
  s.homepage         = "https://github.com/gckjdev/iOS_Common.git"
  s.license          = 'MIT'
  s.author           = { "lzc1104" => "527004184@qq.com" }
  s.source           = { :git => "https://github.com/gckjdev/iOS_Common.git", :tag => s.version ,:submodules => true}
  s.requires_arc = true
  s.frameworks = 'UIKit'
#s.ios.deployment_target = '5.0'
  s.source_files = 'Common/Classes/**/*'
  # s.resource_bundles = {
  #   'WinTourLibrary' => ['Common/Assets/*.png']
  # }
  s.dependency 'leveldb-library', '~> 1.18.2'
#s.public_header_files = 'Pod/Classes/**/**/**/*.h'


end
