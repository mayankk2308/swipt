//: Playground - noun: a place where people can play

import Swipt
import Foundation
import PlaygroundSupport

let unixScript = "echo \"hello world\""
//let desktop = "/Users/mayank/Desktop/"
//let scripts = ["\(desktop)test.sh", "\(desktop)test2.sh"]

let swiptManager = SwiptManager()

swiptManager.execute(unixScriptText: unixScript) { error, output in
    print(output ?? "No output")
}

//swiptManager.asyncExecute(appleScriptText: "tell application \"Finder\" to activate") { error, output in
//    print(error, output)
//}
//
//PlaygroundPage.current.needsIndefiniteExecution = true
