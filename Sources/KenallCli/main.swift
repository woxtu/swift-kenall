import Foundation
import Kenall

guard CommandLine.arguments.count > 1 else {
    print("""
    OVERVIEW: A command-line tool for Kenall API

    USAGE: kenall-cil <postal-code>
    """)

    exit(EXIT_SUCCESS)
}

guard let apiKey = ProcessInfo.processInfo.environment["KENALL_API_KEY"] else {
    print("""
    Set your Kenall API key to environment variable "KENALL_API_KEY"
    """)

    exit(EXIT_FAILURE)
}

let semaphore = DispatchSemaphore(value: 0)

let client = KenallClient(apiKey: apiKey)
let postalCode = CommandLine.arguments[1]

client.address(postalCode: postalCode) { result in
    dump(result)

    semaphore.signal()
}

semaphore.wait()
