
import Foundation
import Combine

public protocol URLSessionProtocol {
    typealias DataTaskPublisher = AnyPublisher<Data, Error>
    func dataTaskPublisher(for request: URLRequest) -> DataTaskPublisher
}
