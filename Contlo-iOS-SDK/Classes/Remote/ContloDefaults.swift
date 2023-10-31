import Foundation

class ContloDefaults {
    
    // MARK: - User Defaults Keys
    private enum Keys {
        static let username = "username"
        static let age = "age"
        static let isLoggedIn = "isLoggedIn"
        
        static let PREFERENCE_NAME = "contlosdk"
        static let CONTLO_DEFAULT_CHANNEL_ID = "contlo_default_channel"
        static let CONTLO_DEFAULT_CHANNEL_NAME = "Marketing Channel"
        static let CONTLO_DEFAULT_CHANNEL_DESC = "Marketing Channel for Contlo Platform"
        static let EMAIL = "email"
        static let PHONE_NUMBER = "phone_number"
        static let API_KEY = "API_KEY"
        static let FCM_TOKEN = "FCM_TOKEN"
        static let MOBILE_PUSH_CONSENT = "MOBILE_PUSH_CONSENT"
        static let AD_ID = "AD_ID"
        static let PACKAGE_NAME = "package_name"
        static let APP_NAME = "app_name"
        static let APP_VERSION = "app_version"
        static let MODEL = "model"
        static let MANUFACTURER = "manufacturer"
        static let NETWORK_TYPE = "network_type"
        static let EXTERNAL_ID = "EXTERNAL_ID"
        static let API_LEVEL = "api_level"
        static let OS_TYPE = "os_type"
        static let OS_VERSION = "os_version"
        static let SOURCE = "source"
        static let SDK_VERSION = "sdk_version"
        static let DEVICE_EVENT_TIME = "device_event_time"
        static let TIMEZONE = "timezone"
        static let NEW_APP_INSTALL = "NEW_APP_INSTALL"
        static let AD_ID_FCM_FOUND = "AD_ID_FCM_FOUND"
        static let PUSH_CONSENT_FCM_FOUND = "PUSH_CONSENT_FCM_FOUND"
        static let LAST_SYNC_TIME = "LAST_SYNC_TIME"
        static let CONFIG_TIME_FRAME = "CONFIG_TIME_FRAME"
        static let REMOTE_LOGGING = "REMOTE_LOGGING"
        static let BRAND_ICON_IN_NOTIFICATION = "BRAND_ICON_IN_NOTIFICATION"
        static let REMOTE_LOGGING_LEVEL = "REMOTE_LOGGING_LEVEL"
        static let RELEASE_BUILD_LOGGING = "RELEASE_BUILD_LOGGING"
        static let LOGS_COUNT = "LOGS_COUNT"
        static let EVENT_TYPE = "event_type"
        static let LOGO_URL = "LOGO_URL"

        static let LOGS_COUNT_THRESHOLD = 10
        static let SOME_ERROR_OCCURRED = "Some error occured"
        static let CONTLO_LOGS_FILE = "/contlo_logs.txt"
        static let APPLICATION_JSON = "application/json"
    }
    
    // MARK: - Set Defaults
    static func setApiKey(_ apiKey: String) {
        UserDefaults.standard.set(apiKey, forKey: Keys.API_KEY)
    }
    
    static func setFcmKey(_ fcmKey: String) {
        UserDefaults.standard.set(fcmKey, forKey: Keys.FCM_TOKEN)
    }
    
    static func setPushConsent(_ consent: Bool) {
        UserDefaults.standard.set(consent, forKey: Keys.MOBILE_PUSH_CONSENT)
    }
    
    static func setAppVersion(_ version: String) {
        UserDefaults.standard.set(version, forKey: Keys.APP_VERSION)
    }
    
    static func setPackageName(_ packageName: String) {
        UserDefaults.standard.set(packageName, forKey: Keys.PACKAGE_NAME)
    }
    
    static func setAppName(_ appName: String) {
        UserDefaults.standard.set(appName, forKey: Keys.APP_NAME)
    }
    
    static func setEmail(_ email: String) {
        UserDefaults.standard.set(email, forKey: Keys.EMAIL)
    }
    
    static func setPhoneNumber(_ phoneNumber: String) {
        UserDefaults.standard.set(phoneNumber, forKey: Keys.PHONE_NUMBER)
    }
    
    static func setNewAppInstall(_ isNewInstall: Bool) {
        UserDefaults.standard.set(isNewInstall, forKey: Keys.NEW_APP_INSTALL)
    }
    
    static func setFcmFound(_ found: Bool) {
        UserDefaults.standard.set(found, forKey: Keys.AD_ID_FCM_FOUND)
    }
    
    static func setAdvertisingId(_ adId: String) {
        UserDefaults.standard.set(adId, forKey: Keys.AD_ID)
    }
    
    static func setSource(_ source: String) {
        UserDefaults.standard.set(source, forKey: Keys.SOURCE)
    }
    
    static func setLastSyncTime(_ timestamp: TimeInterval) {
        UserDefaults.standard.set(timestamp, forKey: Keys.LAST_SYNC_TIME)
    }
    
    static func setConfigTimeframe(_ timeframe: Int) {
        UserDefaults.standard.set(timeframe, forKey: Keys.CONFIG_TIME_FRAME)
    }
    
    static func setRemoteLogging(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: Keys.REMOTE_LOGGING)
    }
    
    static func setBrandIconInNotification(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: Keys.BRAND_ICON_IN_NOTIFICATION)
    }
    
    static func setRemoteLoggingLevel(_ level: Int) {
        UserDefaults.standard.set(level, forKey: Keys.REMOTE_LOGGING_LEVEL)
    }
    
    static func setLogsCount(_ count: Int) {
        UserDefaults.standard.set(count, forKey: Keys.LOGS_COUNT)
    }
    
    static func setLoggingForReleaseBuild(_ isEnabled: Bool) {
        UserDefaults.standard.set(isEnabled, forKey: Keys.RELEASE_BUILD_LOGGING)
    }
    
    static func setLogoUrl(_ url: String) {
        UserDefaults.standard.set(url, forKey: Keys.LOGO_URL)
    }
    
    // MARK: - Get Defaults
    
    static func getApiKey() -> String? {
        return UserDefaults.standard.string(forKey: Keys.API_KEY)
    }
    
    static func getFcmKey() -> String? {
        return UserDefaults.standard.string(forKey: Keys.FCM_TOKEN)
    }
    
    static func getPushConsent() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.MOBILE_PUSH_CONSENT)
    }
    
    static func getAppVersion() -> String? {
        return UserDefaults.standard.string(forKey: Keys.APP_VERSION)
    }
    
    static func getPackageName() -> String? {
        return UserDefaults.standard.string(forKey: Keys.PACKAGE_NAME)
    }
    
    static func getAppName() -> String? {
        return UserDefaults.standard.string(forKey: Keys.APP_NAME)
    }
    
    static func getEmail() -> String? {
        return UserDefaults.standard.string(forKey: Keys.EMAIL)
    }
    
    static func getPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: Keys.PHONE_NUMBER)
    }
    
    static func isNewAppInstall() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.NEW_APP_INSTALL)
    }
    
    static func isFcmFound() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.AD_ID_FCM_FOUND)
    }
    
    static func getAdvertisingId() -> String? {
        return UserDefaults.standard.string(forKey: Keys.AD_ID)
    }
    
    static func getSource() -> String? {
        return UserDefaults.standard.string(forKey: Keys.SOURCE)
    }
    
    static func getLastSyncTime() -> TimeInterval {
        return UserDefaults.standard.double(forKey: Keys.LAST_SYNC_TIME)
    }
    
    static func getConfigTimeframe() -> Int {
        return UserDefaults.standard.integer(forKey: Keys.CONFIG_TIME_FRAME)
    }
    
    static func isRemoteLoggingEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.REMOTE_LOGGING)
    }
    
    static func showBrandIconInNotification() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.BRAND_ICON_IN_NOTIFICATION)
    }
    
    static func getRemoteLoggingLevel() -> Int {
        return UserDefaults.standard.integer(forKey: Keys.REMOTE_LOGGING_LEVEL)
    }
    
    static func getLoggingCount() -> Int {
        return UserDefaults.standard.integer(forKey: Keys.LOGS_COUNT)
    }
    
    static func isLoggingForReleaseBuild() -> Bool {
        return UserDefaults.standard.bool(forKey: Keys.RELEASE_BUILD_LOGGING)
    }
    
    static func getLogoUrl() -> String? {
        return UserDefaults.standard.string(forKey: Keys.LOGO_URL)
    }
    // MARK: - Synchronize Defaults
    
    static func synchronize() {
        UserDefaults.standard.synchronize()
    }
}
