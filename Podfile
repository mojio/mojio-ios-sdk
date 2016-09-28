# Uncomment this line to define a global platform for your project
# platform :ios
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'MojioSDK.xcworkspace'

target 'MojioSDK' do
    xcodeproj 'MojioSDK.xcodeproj'

    pod 'Alamofire', '3.5.0'
    pod 'SwiftyJSON', '2.3.2'
    pod 'ObjectMapper', '~> 1.1'
    pod 'RealmSwift', '1.1.0'
    pod 'KeychainSwift', '~> 3.0'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'SwiftWebSocket'

end

target 'MojioSDKTests' do
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end
