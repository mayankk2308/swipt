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
    
    /// Swift Core Service object for script processing and management.
    private static let core = SwiptCore()
    
    /// Executes a string representation of unix commands.
    ///
    /// - Parameters:
    ///   - scriptText: Any `unix` command
    ///   - privilegeLevel: Required privilege level (default = `user`)
    ///   - completionHandler: Handles script completion
    /// - Note: Take caution when using unix scripts directly as strings, as problems with symbol escaping may prevent AppleScript from correctly executing it.
    public static func execute(unixScriptText scriptText: String, withPrivilegeLevel privilegeLevel: Privileges? = .user, completionHandler: RequestHandler) {
        core.execute(unixScriptText: scriptText, withPrivilegeLevel: privilegeLevel, completionHandler: completionHandler)
    }
    
    /// Execute a provided script file.
    ///
    /// - Parameters:
    ///   - scriptFileName: File path to script
    ///   - scriptArgs: Arguments for script
    ///   - privilegeLevel: Required privilege level (default = `user`)
    ///   - shellType: Choice of shell (default = `/bin/sh`)
    ///   - completionHandler: Handles script completion
    public static func execute(unixScriptFile scriptPath: String, withArgs scriptArgs: [String]? = nil, withPrivilegeLevel privilegeLevel: Privileges? = .user, withShellType shellType: ShellType? = .sh, completionHandler: RequestHandler) {
        core.execute(unixScript: scriptPath, withArgs: scriptArgs, withPrivilegeLevel: privilegeLevel, withShellType: shellType, completionHandler: completionHandler)
    }

}
