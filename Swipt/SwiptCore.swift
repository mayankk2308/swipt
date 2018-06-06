//
//  SwiptCore.swift
//  Swipt
//
//  Created by Mayank Kumar on 6/6/18.
//  Copyright © 2018 Mayank Kumar. All rights reserved.
//

import Foundation

/// Defines Swipt Core Service for script processing and management.
internal class SwiptCore {
    
    /// Compiles and executes target AppleScript object.
    ///
    /// - Parameters:
    ///   - aScript: Target `NSAppleScript` object
    ///   - completionHandler: Handles script completion
    private func compileAndExecute(targetScript aScript: NSAppleScript, completionHandler: RequestHandler) {
        var errorInfo: NSDictionary?
        aScript.compileAndReturnError(&errorInfo)
        if let compileFailureData = errorInfo {
            let errorCode = compileFailureData[NSAppleScript.errorNumber] as! Int
            let errorMessage = compileFailureData[NSAppleScript.errorMessage] as! String
            completionHandler(errorCode, errorMessage, "")
            return
        }
        let scriptReturn = aScript.executeAndReturnError(&errorInfo)
        if let executeFailureData = errorInfo {
            let errorCode = executeFailureData[NSAppleScript.errorNumber] as! Int
            let errorMessage = executeFailureData[NSAppleScript.errorMessage] as! String
            completionHandler(errorCode, errorMessage, "")
            return
        }
        guard let scriptReturnString = scriptReturn.stringValue else {
            completionHandler(0, errors[0]!, "")
            return
        }
        completionHandler(0, errors[0]!, scriptReturnString)
    }
    
    /// Executes a string representation of unix commands.
    ///
    /// - Parameters:
    ///   - scriptText: Any `unix` command
    ///   - privilegeLevel: Required privilege level (default = `user`)
    ///   - completionHandler: Handles script completion
    ///   - error: Handles script completion
    ///   - message: Handles script completion
    ///   - output: Handles script completion
    /// - Note: Take caution when using unix scripts directly as strings, as problems with symbol escaping may prevent AppleScript from correctly executing it.
    internal func execute(unixScriptText scriptText: String, withPrivilegeLevel privilegeLevel: Privileges? = .user, completionHandler: RequestHandler) {
        let aScriptText = convertUnixCommandToAppleScript(targetScript: scriptText, withPrivilegeLevel: privilegeLevel)
        guard let aScript = NSAppleScript(source: aScriptText) else {
            completionHandler(-1, errors[-1]!, "")
            return
        }
        compileAndExecute(targetScript: aScript, completionHandler: completionHandler)
    }
    
    /// Execute a provided script file.
    ///
    /// - Parameters:
    ///   - scriptFileName: File path to script
    ///   - scriptArgs: Arguments for script
    ///   - privilegeLevel: Required privilege level (default = `user`)
    ///   - shellType: Choice of shell (default = `/bin/sh`)
    ///   - completionHandler: Handles script completion
    ///   - error: Handles script completion
    ///   - message: Handles script completion
    ///   - output: Handles script completion
    internal func execute(unixScript scriptFileName: String, withArgs scriptArgs: [String]? = nil, withPrivilegeLevel privilegeLevel: Privileges? = .user, withShellType shellType: ShellType? = .sh, completionHandler: RequestHandler) {
        let aScriptText = convertUnixFileToAppleScript(targetScriptFilePath: scriptFileName, withArgs: scriptArgs, withPrivilegeLevel: privilegeLevel, withShellType: shellType)
        guard let extractedAScriptText = aScriptText else {
            completionHandler(-1, errors[-1]!, "")
            return
        }
        guard let aScript = NSAppleScript(source: extractedAScriptText) else {
            completionHandler(-2, errors[-2]!, "")
            return
        }
        compileAndExecute(targetScript: aScript, completionHandler: completionHandler)
    }
}


// MARK: - Unix script processing & management
extension SwiptCore {
    
    /// Manages script privileges
    ///
    /// - Parameters:
    ///   - aScript: Provided script
    ///   - privilegeLevel: Required privilege level (default = `user`)
    /// - Returns: Updated string representation of the script for AppleScript
    private func manageScriptPrivilege(processingAppleScript aScript: String, withPrivilegeLevel privilegeLevel: Privileges? = .user) -> String {
        var finalScript: String = aScript
        guard let privilege = privilegeLevel else {
            return finalScript
        }
        if privilege == .admin {
            finalScript.append(" \(aSAdminPrivilege)")
        }
        return finalScript
    }
    
    /// Manages input script files
    ///
    /// - Parameters:
    ///   - scriptPath: Path to script
    ///   - scriptArgs: Arguments for script
    ///   - privilegeLevel: Required privilege level (default = `user`)
    ///   - shellType: Choice of shell (default = `/bin/sh`)
    /// - Returns: Updated string representation of the script for AppleScript
    private func convertUnixFileToAppleScript(targetScriptFilePath scriptPath: String, withArgs scriptArgs: [String]? = nil, withPrivilegeLevel privilegeLevel: Privileges? = .user, withShellType shellType: ShellType? = .sh) -> String? {
        var aScript: String = "\(aSSaveTarget) \"\(scriptPath)\"\n"
        aScript.append("\(aSInvokeShell) (\"\((shellType ?? .sh).rawValue) \" & target")
        var accumulatedArgs = ""
        if let args = scriptArgs {
            for arg in args {
                accumulatedArgs.append(" \(arg)")
            }
            aScript.append(" &\"\(accumulatedArgs)\"")
        }
        aScript.append(")")
        return manageScriptPrivilege(processingAppleScript: aScript, withPrivilegeLevel: privilegeLevel)
    }
    
    /// Manages string-based scripts
    ///
    /// - Parameters:
    ///   - script: Script as text
    ///   - privilegeLevel: Required privilege level (default = `user`)
    /// - Returns: Updated string representation of the script for AppleScript
    /// - Note: Take caution when using unix scripts directly as strings, as problems with symbol escaping may prevent AppleScript from correctly executing it.
    private func convertUnixCommandToAppleScript(targetScript script: String, withPrivilegeLevel privilegeLevel: Privileges? = .user) -> String {
        let aScript: String = "\(aSInvokeShell) \"\(script)\""
        return manageScriptPrivilege(processingAppleScript: aScript, withPrivilegeLevel: privilegeLevel)
    }
    
}
