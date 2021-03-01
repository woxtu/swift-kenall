import Foundation

public enum KenallError: Error {
    case unauthorized
    case forbidden
    case notFound
    case methodNotAllowed
    case internalServerError
    case badGateway
    case serviceUnavailable
    case requestFailed(URLError)
    case unexpectedResponse(Error)
    case unknown
}

extension KenallError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .unauthorized:
            return "Unauthorized"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .internalServerError:
            return "Internal Server Error"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case let .requestFailed(error):
            return "Request Failed: \(error.localizedDescription)"
        case let .unexpectedResponse(error):
            return "Unexpected Response: \(error.localizedDescription)"
        case .unknown:
            return "Unknown"
        }
    }
}

extension KenallError: Equatable {
    public static func == (lhs: KenallError, rhs: KenallError) -> Bool {
        switch (lhs, rhs) {
        case (.unauthorized, .unauthorized),
             (.forbidden, .forbidden),
             (.notFound, .notFound),
             (.methodNotAllowed, .methodNotAllowed),
             (.internalServerError, .internalServerError),
             (.badGateway, .badGateway),
             (.serviceUnavailable, .serviceUnavailable),
             (.requestFailed, .requestFailed),
             (.unexpectedResponse, .unexpectedResponse),
             (.unknown, .unknown):
            return true
        default:
            return false
        }
    }
}
