//: Playground - noun: a place where people can play

import Swipt
import Foundation
import PlaygroundSupport

let unixScript = "nvram -p"

let swiptManager = SwiptManager()

swiptManager.asyncExecute(unixScriptText: unixScript, withPrivilegeLevel: .user) { err, mess, out in
    print(err, mess, out)
}

swiptManager.asyncExecute(unixScriptFile: "/Users/mayank/Desktop/test.sh", withArgs: ["a", "b", "c"]) { err, mess, out in
    print(err, mess, out)
}
PlaygroundPage.current.needsIndefiniteExecution = true
