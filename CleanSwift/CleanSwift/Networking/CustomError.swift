import Foundation

enum CustomError: Error {
    case dataError
    case customError(message: String)
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
