import Foundation

public struct AddressResolverResponse: Codable {
    public let version: String
    public let data: [Address]
}
