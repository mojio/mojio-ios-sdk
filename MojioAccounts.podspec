Pod::Spec.new do |spec|
    spec.name = "MojioAccounts"
    spec.version = "3.0.0"
    spec.summary = "Mojio Accounts Framework"
    spec.homepage = "https://github.com/mojio/mojio-ios-sdk"
    spec.license = {type: 'MIT', file: 'LICENSE'}
    spec.authors = {"Mojio, Inc." => 'support@moj.io'}
    spec.social_media_url = "https://twitter.com/getmojio"

    spec.platform = :ios, "11.0"
    spec.requires_arc = true
    spec.source = { git: "https://github.com/mojio/mojio-ios-sdk.git", branch: "phoenix", submodules: true }

    spec.source_files = "MojioSDK/Client/Accounts/**/*.{h,swift}", "MojioSDK/Extensions/**/*.{h,swift}", "MojioSDK/Models/Accounts/**/*.{h,swift}", "MojioSDK/MojioAccounts.h"

    spec.dependency 'Alamofire'
    spec.dependency 'SwiftyJSON'
    spec.dependency 'KeychainSwift'
    spec.dependency 'OHHTTPStubs'
    spec.dependency 'OHHTTPStubs/Swift'
    spec.dependency 'SwiftWebSocket'
    spec.dependency 'SwiftDate'
    spec.dependency 'MojioCore'
end
