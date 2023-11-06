@objc open class Contlo: NSObject {
    static let TAG = "LifecycleHandler"
    
    open class func initialize(apiKey: String, completion: ((String) -> Void)? = nil) {
        ContloDefaults.setup()
        LifecycleHandler.addObservers()
        ContloDefaults.setApiKey(apiKey)
        ConfigService.fetchConfig(apiKey: apiKey) {result in
            switch result {
            case .success(let config):
                completion?("Contlo Initialized")
                Logger.sharedInstance.log(level: LogLevel.Verbose, tag: self.TAG, message: "Contlo Initialized")

            case .error(_):
                Logger.sharedInstance.log(level: LogLevel.Warning, tag: self.TAG, message: "App Moved to foreground")
                return
            }
        }
        if(ContloDefaults.isNewAppInstall()) {
            EventHandler.sendAppEvent(eventName: "Mobile App Installed") { result in
                print(result)
                ContloDefaults.setNewAppInstall(false)
            }
            // Send new app install event
        } else {
            // Check for app update
        }
        let appVersion = ContloDefaults.getAppVersion()
        if(appVersion != Utils.getAppVersion()) {
            EventHandler.sendAppEvent(eventName: "Mobile App Updated") { result in
                print(result)
                ContloDefaults.setAppVersion(Utils.getAppVersion())
            }
        }
        
        Logger.sharedInstance.removeAdapters()
        Logger.sharedInstance.addAdapter(logger: DefaultLogger())
        Logger.sharedInstance.addAdapter(logger: FileLogger())
    }
    
    open class func logout() {
        ContloDefaults.clear()
    }
    
    open class func sendUserData(audience: Audience, isUpdate: Bool = false, completion: @escaping (String) -> Void) {
        ProfileHandler.sendUserData(audience: audience, isUpdate: isUpdate, completion: completion)
    }
    
    open class func sendEvent(eventName: String, eventProperty: [String: String]? = nil, profileProperty: [String: String]? = nil, completion: ((String) -> Void)? = nil) {
        if(eventName.isEmpty) {
            completion?("Event name cannot be empty")
            return
        }
        EventHandler.sendEvent(eventName: eventName, eventProperty: eventProperty, profileProperty: profileProperty, completion: completion)
    }
    
    open class func sendPushConsent(consent: Bool) {
        
    }
}
