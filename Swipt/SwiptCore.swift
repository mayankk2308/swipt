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
    
    private func compileAndExecute(targetScript aScript: NSAppleScript, completionHandler: (Int, String) -> Void) {
        var errorInfo: NSDictionary?
        aScript.compileAndReturnError(&errorInfo)
        if let compileFailureData = errorInfo {
            let errorCode = compileFailureData[NSAppleScript.errorNumber] as! Int
            let errorMessage = compileFailureData[NSAppleScript.errorMessage] as! String
            completionHandler(errorCode, errorMessage)
            return
        }
        aScript.executeAndReturnError(&errorInfo)
        if let executeFailureData = errorInfo {
            let errorCode = executeFailureData[NSAppleScript.errorNumber] as! Int
            let errorMessage = executeFailureData[NSAppleScript.errorMessage] as! String
            completionHandler(errorCode, errorMessage)
            return
        }
        completionHandler(0, errors[0]!)
    }
    
    internal func execute(unixScriptText scriptText: String, withPrivilegeLevel privilegeLevel: Privileges? = .user, completionHandler: (Int, String) -> Void) {
        let aScriptText = convertUnixCommandToAppleScript(targetScript: scriptText, withPrivilegeLevel: privilegeLevel)
        guard let aScript = NSAppleScript(source: aScriptText) else {
            completionHandler(-1, errors[-1]!)
            return
        }
        compileAndExecute(targetScript: aScript, completionHandler: completionHandler)
    }
    
    internal func execute(unixScript scriptFileName: String, withPrivilegeLevel privilegeLevel: Privileges? = .user, withShellType shellType: ShellType? = .sh, completionHandler: (Int, String) -> Void) {
        let aScriptText = convertUnixFileToAppleScript(targetScriptFileName: scriptFileName, withPrivilegeLevel: privilegeLevel, withShellType: shellType)
        guard let extractedAScriptText = aScriptText else {
            completionHandler(-1, errors[-1]!)
            return
        }
        guard let aScript = NSAppleScript(source: extractedAScriptText) else {
            completionHandler(-2, errors[-2]!)
            return
        }
        compileAndExecute(targetScript: aScript, completionHandler: completionHandler)
    }
}


// MARK: - Unix script processing & management
extension SwiptCore {
    
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
    
    private func convertUnixFileToAppleScript(targetScriptFileName scriptName: String, withPrivilegeLevel privilegeLevel: Privileges? = .user, withShellType shellType: ShellType? = .sh) -> String? {
        guard let scriptPath = Bundle.main.path(forResource: scriptName, ofType: "sh") else {
            return nil
        }
        var aScript: String = "\(aSSaveTarget) \"\(shellType ?? .sh) \(scriptPath)\"\n"
        aScript.append("\(aSInvokeShell) target")
        return manageScriptPrivilege(processingAppleScript: aScript, withPrivilegeLevel: privilegeLevel)
    }
    
    private func convertUnixCommandToAppleScript(targetScript script: String, withPrivilegeLevel privilegeLevel: Privileges? = .user) -> String {
        let aScript: String = "\(aSInvokeShell) \"\(script)\""
        return manageScriptPrivilege(processingAppleScript: aScript, withPrivilegeLevel: privilegeLevel)
    }
    
}
