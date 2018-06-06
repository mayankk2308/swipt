//
//  Swipt.swift
//  Swipt
//
//  Created by Mayank Kumar on 4/8/18.
//  Copyright © 2018 Mayank Kumar. All rights reserved.
//

import Foundation

/// Primary scripting interface.
public class SwiptManager {
    
    static let core = SwiptCore()
    
    public static func execute(unixScriptText scriptText: String, withPrivilegeLevel privelegeLevel: Privileges? = .user, completionHandler: (Int, String) -> Void) {
        core.execute(unixScriptText: scriptText, withPrivilegeLevel: privelegeLevel, completionHandler: completionHandler)
    }

}
