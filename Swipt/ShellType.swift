//
//  ShellType.swift
//  Swipt
//
//  Created by Mayank Kumar on 6/6/18.
//  Copyright © 2018 Mayank Kumar. All rights reserved.
//

/// Available shell types
///
/// - bash: To execute using `/bin/bash`
/// - sh: To execute using `/bin/sh` (default)
public enum ShellType: String {
    case bash = "/bin/bash", sh = "/bin/sh"
}
