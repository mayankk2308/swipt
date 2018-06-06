//: Playground - noun: a place where people can play

import Swipt
import Foundation

let unixScript = ""

SwiptManager.execute(unixScriptText: unixScript, withPrivilegeLevel: .user) { error, message, output in
    print(error, message, output)
}

//SwiptManager.execute(unixScriptFile: "/Users/mayank/Desktop/test.sh", withArgs: ["hello","b","c"], withShellType: .bash) { error, message, output in
//    print(error, message, output)
//}
