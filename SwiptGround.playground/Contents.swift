//: Playground - noun: a place where people can play

import Swipt
import Foundation

let unixScript = "opens /Applications"

SwiptManager.execute(unixScriptText: unixScript) { error, message in
    print(error, message)
}
