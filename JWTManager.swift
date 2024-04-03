//
//  JWTManager.swift
//  JWTManager
//
//  Created by Dmitry Kononchuk on 31.03.2024.
//  Copyright © 2024 Dmitry Kononchuk. All rights reserved.
//

import Foundation

final class JWTManager {
    // MARK: - Public Methods
    
    static func decodeJWT(_ jwtToken: String) -> [String: Any]? {
        let segments = jwtToken.components(separatedBy: ".")
        
        guard segments.count == 3,
              let payloadData = base64UrlDecode(segments[1])
        else { return nil }
        
        do {
            if let json = try JSONSerialization.jsonObject(
                with: payloadData
            ) as? [String: Any] {
                return json
            }
        } catch {
            let message = "Error while decoding JSON from JWT:"
            print("\(message) \(error.localizedDescription)")
        }
        
        return nil
    }
    
    // MARK: - Private Methods
    
    private static func base64UrlDecode(_ value: String) -> Data? {
        var base64 = value
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        
        while base64.count % 4 != 0 {
            base64 += "="
        }
        
        return Data(base64Encoded: base64)
    }
}
