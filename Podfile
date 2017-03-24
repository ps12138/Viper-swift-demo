platform :ios, '10.0'
target 'viper_swift_demo' do
  use_frameworks!
  pod 'RealmSwift'
end


post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0' # or '3.0'
    end
  end
end
