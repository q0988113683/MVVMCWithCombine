

import Foundation

public class MockURLSession: URLSessionProtocol {
    private var mockFactory: MockDataProtocol?
    var nextDataTask = MockURLSessionDataTask()
    var nextData: Data?
    var nextError: Error?
    func successHttpURLResponse(request: URLRequest) -> URLResponse {
        return HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: nil)!
    }
    
    public func dataTask(with request: URLRequest, completionHandler: @escaping CompletionHandler) -> URLSessionDataTaskProtocol {
        nextData = mockFactory?.fetchData(url: request.url?.absoluteString ?? "")
        completionHandler(nextData, successHttpURLResponse(request: request), nextError)
        return nextDataTask
    }

    init( factory: MockDataProtocol) {
        mockFactory = factory
    }
}
