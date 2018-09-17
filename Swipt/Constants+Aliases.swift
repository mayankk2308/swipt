//
//  Constants.swift
//  Swipt
//
//  Created by Mayank Kumar on 6/6/18.
//  Copyright © 2018 Mayank Kumar. All rights reserved.
//


/// Handles script termination.
/// - Parameters:
///   - error: Returned error code
///   - message: Return error message
///   - output: Script output/result
public typealias RequestHandler = (_ error: SwiptError?, _ output: String?) -> Void

/// AppleScript: Shell string encapsulation
let aSSaveTarget: String = "set target to quoted form of"

/// AppleScript: Shell invocation call
let aSInvokeShell: String = "do shell script"

/// AppleScript: Shell adminstrator privilege request
let aSAdminPrivilege: String = "with administrator privileges"
