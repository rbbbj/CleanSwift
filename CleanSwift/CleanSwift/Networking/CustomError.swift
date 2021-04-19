import Foundation

enum CustomError: Error {
    case customError(message: String)
    case dataError
}

extension CustomError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .dataError:
            return NSLocalizedString("Data Error.\nPlease try again.", comment: "")
        case .customError(let message):
            return message
        }
    }
}
