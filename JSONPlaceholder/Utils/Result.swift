enum Result<T, E> {
    case success(T)
    case failure(E)

    var value: T? {
        switch self {
        case let .success(value):
            return value
        default:
            return nil
        }
    }

    var error: E? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }

    init(value: T) {
        self = .success(value)
    }

    init(error: E) {
        self = .failure(error)
    }
}
