@testable import Kenall
import XCTest

final class KenallClientTests: XCTestCase {
    struct TestPayload: Codable, Equatable {}

    let client: KenallClient = .init(apiKey: "")
    let request: URLRequest = .init(url: URL(string: "https://example.com")!)

    func testSendRequestFailed() {
        final class TestProtocol: URLProtocolStub {
            override var error: Error? { URLError(.unknown) }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.requestFailed(URLError(.unknown))))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestSuccessful() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 200,
                                httpVersion: nil,
                                headerFields: nil)
            }

            override var data: Data? {
                try? JSONEncoder().encode(TestPayload())
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .success(TestPayload()))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestUnexpectedResponse() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 200,
                                httpVersion: nil,
                                headerFields: nil)
            }

            override var data: Data? {
                Data()
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.unexpectedResponse(DecodingError.dataCorrupted(.init(codingPath: [], debugDescription: "")))))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestUnauthorized() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 401,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.unauthorized))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestForbidden() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 403,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.forbidden))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestNotFound() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 404,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.notFound))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestMethodNotAllowed() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 405,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.methodNotAllowed))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestInternalServerError() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 500,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.internalServerError))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestBadGateway() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 502,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.badGateway))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    func testSendRequestServiceUnavailable() {
        final class TestProtocol: URLProtocolStub {
            override var response: URLResponse? {
                HTTPURLResponse(url: URL(string: "https://example.com")!,
                                statusCode: 503,
                                httpVersion: nil,
                                headerFields: nil)
            }
        }

        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [TestProtocol.self]
        let session = URLSession(configuration: configuration)

        let expectation = XCTestExpectation()
        _ = client.sendRequest(request, using: session) { (result: Result<TestPayload, KenallError>) in
            XCTAssertEqual(result, .failure(.serviceUnavailable))
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1)
    }

    static var allTests = [
        ("testSendRequestFailed", testSendRequestFailed),
        ("testSendRequestSuccessful", testSendRequestSuccessful),
        ("testSendRequestUnauthorized", testSendRequestUnauthorized),
        ("testSendRequestUnexpectedResponse", testSendRequestUnexpectedResponse),
        ("testSendRequestForbidden", testSendRequestForbidden),
        ("testSendRequestNotFound", testSendRequestNotFound),
        ("testSendRequestMethodNotAllowed", testSendRequestMethodNotAllowed),
        ("testSendRequestInternalServerError", testSendRequestInternalServerError),
        ("testSendRequestBadGateway", testSendRequestBadGateway),
        ("testSendRequestServiceUnavailable", testSendRequestServiceUnavailable),
    ]
}
