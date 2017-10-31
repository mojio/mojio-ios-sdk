# Uncomment this line to define a global platform for your project
# platform :ios
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'MojioSDK.xcworkspace'

target 'MojioSDK' do
    project 'MojioSDK.xcodeproj'

    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'ObjectMapper'
    pod 'KeychainSwift'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'SwiftWebSocket', :git => 'https://github.com/mojio/SwiftWebSocket', :branch => 'master'
    pod 'SwiftDate'
end

target 'MojioSDKTests' do
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == 'SwiftWebSocket'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '3.2'
            end
        end
    end
end
