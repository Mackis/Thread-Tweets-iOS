# Uncomment the next line to define a global platform for your project
 platform :ios, '10.0'

target 'Thread Tweets' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Thread Tweets
  pod 'RevealingSplashView'
  pod 'SwiftIcons', :git => 'https://github.com/ranesr/SwiftIcons'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'TBEmptyDataSet'
  pod 'SnapKit'
  pod 'TwitterKit'

  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.2'
          end
      end
  end
  
end
