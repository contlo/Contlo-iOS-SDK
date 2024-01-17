@objc open class Contlo: NSObject {
    static let TAG = "Contlo"
    let consentOnHold = false
    
   @objc open class func initialize(apiKey: String, completion: ((String) -> Void)? = nil) {
        ContloDefaults.setup()
        ContloDefaults.setApiKey(apiKey)
        
        ConfigService.fetchConfig(apiKey: apiKey) {result in
            switch result {
            case .success(_):
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
                if(ContloDefaults.isConsentOnHold() && ContloDefaults.getDeviceToken() != nil) {
                    sendDeviceToken(token: ContloDefaults.getDeviceToken()!)
                }
                ContloDefaults.setNewAppInstall(false)
                ContloDefaults.setAppVersion(Utils.getAppVersion())
                LifecycleHandler.addObservers()
            }
            // Send new app install event
        } else {
            // Check for app update
            let appVersion = ContloDefaults.getAppVersion()
            if(appVersion != Utils.getAppVersion()) {
                EventHandler.sendAppEvent(eventName: "Mobile App Updated") { result in
                    print(result)
                    ContloDefaults.setAppVersion(Utils.getAppVersion())
                }
            }
            LifecycleHandler.addObservers()
        }
        
        Logger.sharedInstance.removeAdapters()
        Logger.sharedInstance.addAdapter(logger: DefaultLogger())
        Logger.sharedInstance.addAdapter(logger: FileLogger())
        Logger.sharedInstance.addAdapter(logger: RemoteLogger())
        
    }
    
    @objc open class func logout() {
        ContloDefaults.clear()
    }
    
    @objc open class func sendUserData(audience: Audience, isUpdate: Bool = false, completion: @escaping (String) -> Void) {
        
        if(audience.userEmail == nil && audience.userPhone == nil) {
            completion("Either Email or Phone is mandatory")
        }
        ProfileHandler.sendUserData(audience: audience, isUpdate: isUpdate, completion: completion)
    }
    
    @objc open class func sendEvent(eventName: String, eventProperty: [String: String]? = nil, profileProperty: [String: String]? = nil, completion: ((String) -> Void)? = nil) {
        if(eventName.isEmpty) {
            completion?("Event name cannot be empty")
            return
        }
        if(ContloDefaults.isTrackingDisabled()) {
            completion?("Tracking is disabled")
            return
        }
        EventHandler.sendEvent(eventName: eventName, eventProperty: eventProperty, profileProperty: profileProperty, completion: completion)
    }
    
    @objc open class func sendPushConsent(consent: Bool, completion: @escaping (String) -> Void) {
        PushHandler.sendPushConsent(consent: consent, completion: completion)
    }
    
    @objc open class func setNotificationPermission(granted: Bool) {
        ContloDefaults.setNotificationEnabled(granted)
    }
    
    @objc open class func sendDeviceToken(token: String) {
         let externalId = ContloDefaults.getExternalId()
        ContloDefaults.setDeviceToken(token)
        if(externalId == nil) {
            ContloDefaults.setConsentOnHold(true)
            return
        }
        if(!token.isEmpty) {
            sendPushConsent(consent: true) {_ in 
                Logger.sharedInstance.log(level: LogLevel.Info, tag: TAG, message: "Successfully sent APNS Token")
            }
        }
    }
    
    @objc open class func registerNotificationClick(response: UNNotificationResponse) {
        let notification = response.notification
        let userInfo = notification.request.content.userInfo
        let actionIdentifier = response.actionIdentifier

        // Check for a specific custom key in the userInfo dictionary
        if let customValue = userInfo["internal_id"] as? String {
            print("Received Contlo notification with custom value: \(customValue)")
            CallbackService.sendNotificationClick(internalId: customValue)
        }
    }
    
    @objc open class func registerNotificationReceive(request: UNNotificationRequest) {
        var bestAttemptContent: UNMutableNotificationContent?
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)

        
        if let bestAttemptContent = bestAttemptContent {
            if let internalIdString = request.content.userInfo["internal_id"] as? String {
                CallbackService.sendNotificationReceive(internalId: internalIdString)
            }
        }
    }
    
    @objc open class func disableTracking(disable: Bool) {
        ContloDefaults.setTrackingDisabled(disable)
    }
}
