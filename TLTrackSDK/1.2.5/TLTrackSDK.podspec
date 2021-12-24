
Pod::Spec.new do |s|
  s.name             = 'TLTrackSDK'
  s.version          = '1.2.5'
  s.summary          = '全埋点SDK'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
"全埋点私有库，内部使用"
                       DESC

  s.homepage         = 'https://github.com/panshouheng/TLTrackSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'panshouheng' => 'shouheng.pan@tineco.com' }
  s.source           = { :git => 'https://github.com/panshouheng/TLTrackSDK.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'

  s.source_files = 'TLTrackSDK/Classes/**/*'
  
end
