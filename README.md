![Header](https://raw.githubusercontent.com/mayankk2308/swipt/master/Resources/hero.png)
Swipt is an easy-to-use API for **macOS Yosemite** or later, and enables developers to execute **shell** scripts directly in Swift. This allows for some interesting special use cases, and *may* circumvent the need to use **XPC Services**.

## Installation
You have multiple options to install Swipt:

### Cocoapods (Coming Soon)
In your **Podfile**, add:
```ruby
pod 'Swipt'
```

### Carthage (Coming Soon)
In your **Cartfile**, add:
```shell
github "mayankk2308/swipt"
```

## Basics
Import **Swipt** module:
```swift
import Swipt
```

Initialize management object as follows:
```swift
let swiptManager = SwiptManager()
```

To execute scripts, use one of the `execute` methods:
```swift
swiptManager.execute(...)
```

## Features and Options
You can specify the privilege level you need using `Privileges`:
- **user** - standard user-level privileges (default)
- **admin** - superuser privileges (macOS UI will prompt for password **automatically**)

You can specify the shell type you need using `ShellType`:
- **sh** - Shell (default)
- **bash** - Bourne Again Shell
- **ksh** - Korn Shell
- **csh** - C Shell
- **zsh** - Z Shell
- **tcsh** - T Shell

## Usage
There are many ways to execute scripts in **Swipt** for as much flexibility as possible.

### Single-Threaded Low-Perf Workloads
You can execute **unix commands** by simply passing in a textual representation using:
```swift
let sampleUnixCommand = "echo hello"
swiptManager.execute(unixScriptText: sampleUnixCommand)
```

You can specify privileges easily:
```swift
swiptManager.execute(unixScriptText: sampleUnixCommand, withPrivilegeLevel: .admin)
```

You can easily handle script outputs and errors:
```swift
swiptManager.execute(unixScriptText: sampleUnixCommand) { error, message, output in {
    // handle errors & output
}
```

You can provide script files, which is more robust and portable:
```swift
let scriptFile = "/path/to/script.sh"
swiptManager.execute(unixScriptPath: scriptFile)
```

You can specify privileges in a similar manner shown earlier, but for files, you may additionally specify the shell type:
```swift
swiptManager.execute(unixScriptPath: scriptFile, withShellType: .bash)
```

Completion handlers work in a similar manner as shown earlier. You can also directly execute **AppleScript** as text.

### Multi-Threaded High-Perf Workloads
In most cases, it is optimal to execute scripts on a separate thread. **Swipt** allows you to do this with no extra work:
```swift
let sampleUnixCommand = "echo hello"
swiptManager.asyncExecute(unixScriptText: sampleUnixCommand)
```

Just use the `async` variants of the single-threaded functions. Completion handlers work in exactly the same way as they do for single-threaded calls, as long as the parent process (typically an Application) is alive.

Additionally, you may execute batches of scripts, each with their own set of privileges (`[Privileges]`), shell types (`[ShellType]`), and arguments (`[[String]]`), all optional:
```swift
let scriptBatch = [..String (file paths)..]()
swiptManager.executeSerialBatch(unixScriptFiles: scriptBatch)
// or provide arguments, shell types, and Privileges
let privilegeLevels = [...Privileges...]
swiptManager.executeSerialBatch(unixScriptFiles: scriptBatch, withPrivilegeLevels: privilegeLevels, ...)
```

This function does not support a completion handler at the moment. A more comprehensive threading system will be implemented at a later date.

## License
This project is available under the **MIT** license. Please see the [license](https://github.com/mayankk2308/swipt/blob/master/LICENSE.md) file for more information.
