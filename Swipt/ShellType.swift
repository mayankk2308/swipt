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
/// - ksh: To execute using `/bin/ksh`
/// - csh: To execute using `/bin/csh`
/// - zsh: To execute using `/bin/zsh`
/// - tcsh: To execute using `/bin/tcsh`
public enum ShellType: String {
    case bash = "/bin/bash", sh = "/bin/sh", ksh = "/bin/ksh", csh = "/bin/csh", zsh = "/bin/zsh", tcsh = "/bin/tcsh"
}
