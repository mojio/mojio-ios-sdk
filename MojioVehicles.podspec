Pod::Spec.new do |spec|
    spec.name = "MojioVehicles"
    spec.version = "3.0.0"
    spec.summary = "Mojio Vehicle Framework"
    spec.homepage = "https://github.com/mojio/mojio-ios-sdk"
    spec.license = {type: 'MIT', file: 'LICENSE'}
    spec.authors = {"Mojio, Inc." => 'support@moj.io'}
    spec.social_media_url = "https://twitter.com/getmojio"

    spec.platform = :ios, "9.0"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/mojio/mojio-ios-sdk.git", branch: "phoenix", submodules: true }

    spec.source_files = "MojioSDK/Client/Shared/**/*.{h,swift}", "MojioSDK/Client/Vehicles/**/*.{h,swift}", "MojioSDK/Env/**/*.{h,swift}", "MojioSDK/Extensions/**/*.{h,swift}", "MojioSDK/Models/Shared/**/*.{h,swift}", "MojioSDK/Models/Vehicles/**/*.{h,swift}", "MojioSDK/Shared/**/*.{h,swift}", "MojioSDK/*.{h,swift}"

    spec.dependency 'Alamofire'
    spec.dependency 'SwiftyJSON'
    spec.dependency 'KeychainSwift'
    spec.dependency 'OHHTTPStubs'
    spec.dependency 'OHHTTPStubs/Swift'
    spec.dependency 'SwiftWebSocket'
    spec.dependency 'SwiftDate'
end
