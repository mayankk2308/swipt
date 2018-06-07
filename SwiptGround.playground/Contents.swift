//: Playground - noun: a place where people can play

import Swipt
import Foundation
import PlaygroundSupport

let unixScript = "nvram -p"
let desktop = "/Users/mayank/Desktop/"
let scripts = ["\(desktop)test.sh", "\(desktop)test2.sh"]

let swiptManager = SwiptManager()

swiptManager.asyncExecute(appleScriptText: "tell application \"Finder\" to activate") { e, m, o in
    print(e, m, o)
}

//swiptManager.executeSerialBatch(unixScriptFiles: scripts)
