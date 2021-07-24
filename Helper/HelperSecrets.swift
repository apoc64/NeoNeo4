//
//  HelperSecrets.swift
//  Created by Steve Schwedt on 7/23/21.
//

import Foundation

extension Helper {
    
    /** Dictionary of credentials from xcconfig file*/
    static var secrets: [String: Any]? {
        return configDictionary?["HELPER_SECRETS"] as? [String: Any]
    }
    
    private static var configDictionary: [String: Any]? {
        guard let json = Bundle.main.infoDictionary?["HELPER_CONFIG"] as? String else {
            log("Failed to create Helper Config from info.plist", priority: .high)
            return nil
        }
        
        return dictionary(json: json, errorMessage: "Config from plist")
    }
    
    private static func dictionary(json: String, errorMessage: String) -> [String: Any]? {
        guard let data = json.data(using: .utf8) else {
            log("Data Encoding Failed for: \(errorMessage)", priority: .high)
            return nil
        }
        
        do {
           let dict = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            
            return dict
        } catch {
            log("Json Serialization Failed for: \(errorMessage)", priority: .high)
            return nil
        }
    }
}
