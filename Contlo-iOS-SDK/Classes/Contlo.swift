@objc open class Contlo: NSObject {
    
    open class func initialize(apiKey: String) {
        print("Contlo initalize")
        ContloDefaults.setApiKey(apiKey)
        ConfigService.fetchConfig(apiKey: apiKey)
        // API Call to check for config
        
        if(ContloDefaults.isNewAppInstall()) {
            // Send new app install event
        } else {
            // Check for app update
        }
        
        var httpClient = HttpClient()
        let urlData = "https://api1.contlo.com/v2/track"
//        httpClient.sendPostRequest(url: URL(string: urlData)!, data: "ad", completion: {_ in
//
//        })
    }
    
//    open class sendEvent(eventName: String) {
//
//    }
    
//    open class sendEvent(eventName: String, eventProperty: [String, String]  = nil, profileProperty: [String, String] = nil) {
//
//    }
//
//    open class sendUserData(audience: String, isUpdate: Bool = false) {
//
//    }
//
//    open class sendPushConsent(consent: Bool) {
//        // First check for SDK initialize
//        //then check for Notification permission
//        // If enabled, then send push consent API call
//    }
    
    open class func logout() {
        ContloDefaults.clear()
    }
    
    open class func sendUserData() {
            var httpClient = HttpClient()
        let urlData = "https://api1.contlo.com/v2/track"
//        let urlData = "https://contlo.free.beeceptor.com/todos"
//        let urlData = "https://c3b4fe4a-024b-4e51-906b-c1e64dbcfcaf.mock.pstmn.io"
        let data = "{\"device_event_time\":1698672003725,\"event\":\"order_phone\",\"event_id\":1800977456615999037,\"fcm_token\":\"dFJEcQ5kQBK1KChmtJI562:APA91bGpDr3hEfn_p1IRODRq_XUEhkYJqTZKWjnYZKrJXp3n_SifxkHRItN4JP_h2JbxkVpGRbnlh2NrLBWDjAKpm5wegeYMjr9BbYQl0VPlaRWb-FsyiYgO8_WZCKHhx8arioaQr5Rq\",\"properties\":{\"api_level\":\"33\",\"app_version\":\"1.0.0\",\"timezone\":\"Asia/Kolkata\",\"os_version\":\"13\",\"source\":\"Mobile\",\"manufacturer\":\"Google\",\"app_name\":\"MobileSDK\",\"event_type\":\"custom\",\"os_type\":\"Android\",\"package_name\":\"com.contlo.mobilesdk\",\"sdk_version\":\"1.0.0\",\"model\":\"sdk_gphone64_arm64\",\"network_type\":\"WiFi\"},\"mobile_push_consent\":true}"
        httpClient.sendPostRequest(url: URL(string: urlData)!, data: data, completion: {response in
            print(response)
        })
    }
}
