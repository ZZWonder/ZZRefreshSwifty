

Pod::Spec.new do |s|
  s.name             = 'ZZRefreshSwifty'
  s.version          = '0.1.0'
  s.summary          = 'A swift tool to refrsh'

  s.description      = <<-DESC
A swift tool to refrsh, use cocoapods to install this pod, have fun! 
                       DESC

  s.homepage         = 'https://github.com/ZZWonder/ZZRefreshSwifty'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rain-star' => 'vintrs@163.com' }
  s.source           = { :git => 'https://github.com/ZZWonder/ZZRefreshSwifty.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZZRefreshSwifty/Classes/**/*'
  
  # s.resource_bundles = {
  #   'ZZRefreshSwifty' => ['ZZRefreshSwifty/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'SnapKit', '~> 3.2.0'
end
