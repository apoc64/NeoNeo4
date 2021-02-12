# NeoNeo4

This is an architectural prototype for building apps using SwiftUI and Combine. The iOS app fetches data from public APIs and displays the result in List Views.

## Setup

With Xcode 12+, MacOS 10.15+, and an iOS Simulator running 14+ setup and the repo cloned, open NeoNeo4.xcodeproj in Xcode.

To run the app on the selected simulator or authorized device, press Command + R, or press the play button in the toolbar.

To run the tests, press Command + U, or use the dropdown from the play button.

## About the App

The app uses `@main` and the App protocol. It does not contain an AppDelegate, however, one can be added, using `@UIApplicationDelegateAdaptor`. Additionally, the app does not include UIKit. Upon the automatic initialization of the NeoNeo4App struct, it configures Helper.

## Helper

The Helper group is intended as a collection generalized helpers for building clean, testable apps with a networking layer based on Combine. Code within the Helper group should not call code from the primary project, so that it could be reused.

### Structure

Helper wraps a number of Apple APIs in protocols, and configures them using dependency injection. TestHelper mocks these to aid in testing. When working on the primary app, these APIs are accessed with the following syntax:

```
NetworkingManager.dataTaskPublisher(for: HTTPRequest)  // Replacing URLSession.shared.dataTaskPublisher
// -> AnyPublisher<APIResponse, URLError>

UserDefaults.fromContainer  // Replacing UserDefaults.shared
NotificationCenter.fromContainer  // Replacing NotificationCenter.default
NSManagedObjectContext.fromContainer.main  // Provides a managed object context
```

Initial setup can be done in the init of a struct conforming to App, marked with `@main`, or in an AppDelegate:
```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let config = HelperConfig(
        loggingPriority: .low,
        dataTaskPublisher: URLSession.shared,
        userDefaultable: UserDefaults.standard,
        notifiable: NotificationCenter.default,
        analyticsProviding: NoAnalytics())
    Helper.configure(config)

    return true
}
```

### ServiceResponseModel

Helper contains the protocol ServiceResponseModel, which allows Decodable models to fetch themselves using Combine and NetworkingManager with the following syntax:

```
MyServiceResponseModel.performRequest(request: HTTPRequest) -> AnyPublisher<Self, Error>
MyServiceResponseModel.performRequest() -> AnyPublisher<Self, Error>  // performs a default request defined in the primary app

// default request definition:
extension MyServiceResponseModel: ServiceResponseModel {
    static var defaultRequest: HTTPRequest? {
      HTTPRequest(...)
    }
}
```

### TestHelper

TestHelper configures mocks for the test suite. To configure TestHelper once, prior to running tests, the TestHelper class must be registered as the Principal Class in the test target's info.plist. Be sure to include the test target's name along with TestHelper.
```
<key>NSPrincipalClass</key>
<string>NeoNeo4Tests.TestHelper</string>
```

Alternatively, you may run TestHelper.setup() in the setup for tests, but this will run multiple times unnecessarily.

To mock a default service request for a test, add a json file for the sample response into the test target, and run:
```
MockURLSession.mock(request: MyServiceResponseModel.defaultRequest, jsonFileName: "myServiceResponse")
```

### Logging and Analytics

Helper includes the global function log("message"). By itself, it works like print outside of release mode. It also takes optional parameters to set the console priority, whether to send the message to analytics, and a dictionary of options.
```
func log(_ string: String, priority: LoggingPriority = .required, analytics: Bool = false, options: [String: Any]? = nil)
```

With analytics set to true, the message and options will be sent to the instance conforming to the AnalyticsProviding protocol, set up with Helper.configure(config). Helper comes with NoAnalytics() to send no analytics. To enable analytics, write a bridge conforming to the AnalyticsProviding protocol that handles sending analytics, and pass that in to the HelperCofig.
