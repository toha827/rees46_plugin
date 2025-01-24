#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# Run `pod lib lint rees46_plugin.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'rees46_plugin'
  s.version          = '0.0.1'
  s.summary          = 'Flutter plugin for REES46 SDK'
  s.description      = <<-DESC
Flutter plugin for integrating REES46 personalization and recommendation services into iOS applications.
                       DESC
  s.homepage         = 'https://rees46.com'  # Changed to https
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'REES46' => 'support@rees46.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'Flutter'
  s.dependency 'REES46', '~> 1.0'  # Добавлена версия SDK
  
  s.platform = :ios, '12.0'
  s.ios.deployment_target = '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386'  #  arm64 из исключений
  }
  s.swift_version = '5.0'
end