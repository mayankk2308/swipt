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
    
    public static func execute(withScript script: String, terminationHandler: ((Int) -> Void)?) {
        guard let appleScript = NSAppleScript(source: script) else {
            if terminationHandler != nil {
                terminationHandler!(-1)
            }
            return
        }
        var scriptError: NSDictionary?
        appleScript.executeAndReturnError(&scriptError)
        if let error = scriptError {
            let errorCode = error["NSAppleScriptErrorNumber"] as! Int
            if terminationHandler != nil {
                terminationHandler!(errorCode)
            }
        } else {
            if terminationHandler != nil {
                terminationHandler!(0)
            }
        }
    }
}
