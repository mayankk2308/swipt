//
//  Errors.swift
//  Swipt
//
//  Created by Mayank Kumar on 6/6/18.
//  Copyright © 2018 Mayank Kumar. All rights reserved.
//

/// Defines possible script completion errors.
///
/// - ASEmbedError: Error embedding unix command into AppleScript
/// - ASGenError: Error generating AppleScript
/// - UnknownError: Unknown error
/// - ExecutionError: Error occurred during script runtime
public enum SwiptError {
    case ASEmbedError(code: Int, message: String)
    case ASGenError(code: Int, message: String)
    case UnknownError(code: Int, message: String)
    case ExecutionError(code: Int, message: String)
}
