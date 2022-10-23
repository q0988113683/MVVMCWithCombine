

import Foundation
import Combine

public class MockURLSession: URLSessionProtocol {

    private var mockFactory: MockDataProtocol?
    var nextData: Data?
    var nextError: Error!
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }

    init( factory: MockDataProtocol) {
        mockFactory = factory
    }
    
    public func dataTaskPublisher(for request: URLRequest) -> DataTaskPublisher {
        nextData = mockFactory?.fetchData(url: request.url?.absoluteString ?? "")
        
        if let data = nextData {
            let subject = CurrentValueSubject<Data, Error>(data)
            let publishers = subject.eraseToAnyPublisher()
            return publishers
        }else {
            let subject = PassthroughSubject<Data, Error>()
            subject.send(completion: .failure(nextError))
            let publishers = subject.eraseToAnyPublisher()
            return publishers
        }
    }
}
