//: Playground - noun: a place where people can play

import Swipt
import Foundation

let unixScript = "echo yo"

SwiptManager.execute(unixScriptText: unixScript) { error, message, output in
    print(error, message, output)
}

//SwiptManager.execute(unixScriptFile: "/Users/mayank/Desktop/test.sh", withShellType: .bash) { error, message, output in
//    print(error, message, output)
//}
