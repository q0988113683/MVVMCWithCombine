
import Foundation

public protocol URLSessionProtocol {
    typealias CompletionHandler = (Data?, URLResponse?, Error?) -> Void

    func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskProtocol
}
