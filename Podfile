# Uncomment this line to define a global platform for your project
# platform :ios
# Uncomment this line if you're using Swift
use_frameworks!

workspace 'MojioSDK.xcworkspace'

def base_pods
    pod 'Alamofire'
    pod 'SwiftyJSON'
    pod 'ObjectMapper'
    pod 'KeychainSwift'
    pod 'OHHTTPStubs'
    pod 'OHHTTPStubs/Swift'
    pod 'SwiftWebSocket', :git => 'https://github.com/mojio/SwiftWebSocket', :commit => 'd39576a'
    pod 'SwiftDate'
    pod 'RxSwift'
end

target 'Accounts' do
    project 'MojioSDK.xcodeproj'

    base_pods
end

target 'Vehicles' do
    project 'MojioSDK.xcodeproj'

    base_pods
end

target 'Pets' do
    project 'MojioSDK.xcodeproj'

    base_pods
end

# target 'Tests' do
#     pod 'OHHTTPStubs'
#     pod 'OHHTTPStubs/Swift'
# end
