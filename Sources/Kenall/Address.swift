import Foundation

public struct Address: Codable {
    public let jisx0402: String
    public let oldCode: String
    public let postalCode: String
    public let prefecture: String
    public let prefectureKana: String
    public let city: String
    public let cityKana: String
    public let town: String
    public let townKana: String
    public let townRaw: String
    public let townKanaRaw: String
    public let koaza: String
    public let kyotoStreet: String
    public let building: String
    public let floor: String
    public let townPartial: Bool
    public let townAddressedKoaza: Bool
    public let townMulti: Bool
    public let townChome: Bool
    public let corporation: Corporation?
}
