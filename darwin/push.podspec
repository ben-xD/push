#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint push.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'push'
  s.version          = '0.0.1'
  s.summary          = 'Push notifications in Flutter without firebase_messaging.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://push.orth.uk'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Ben Butterworth' => 'push@orth.uk' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  # As per https://docs.flutter.dev/packages-and-plugins/developing-packages#shared-ios-and-macos-implementations
  s.ios.dependency 'Flutter'
  s.osx.dependency 'FlutterMacOS'
  s.ios.deployment_target = '11.0'
  s.osx.deployment_target = '10.14'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
