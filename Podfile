# Uncomment this line to define a global platform for your project
platform :ios, '10.0'
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'MojioSDK.xcworkspace'

def base_pods
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'KeychainSwift'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'SwiftWebSocket', :git => 'https://github.com/mojio/SwiftWebSocket', :commit => 'd39576a'
    pod 'SwiftDate'
end

target 'Core' do
    project 'MojioSDK.xcodeproj'

    base_pods
end

target 'Accounts' do
    project 'MojioSDK.xcodeproj'

    base_pods
    pod 'MojioCore', :path => '.'
end

target 'Images' do
    project 'MojioSDK.xcodeproj'

    base_pods
    pod 'AlamofireImage'
    pod 'MojioCore', :path => '.'
end

target 'Vehicles' do
    project 'MojioSDK.xcodeproj'

    base_pods
    pod 'MojioCore', :path => '.'
end

target 'Pets' do
    project 'MojioSDK.xcodeproj'

    base_pods
    pod 'MojioCore', :path => '.'
end

target 'Tests' do
     base_pods
     #pod 'OHHTTPStubs'
     #pod 'OHHTTPStubs/Swift'
end
