import Foundation
#if canImport(FoundationNetworking)
import FoundationNetworking
#endif

open class KenallClient {
    public let endpoint = URL(string: "https://api.kenall.jp/v1/")!
    public let apiKey: String

    public init(apiKey: String) {
        self.apiKey = apiKey
    }

    func sendRequest<Response>(_ request: URLRequest,
                               using session: URLSession,
                               completionHandler: @escaping (Result<Response, KenallError>) -> Void)
        -> URLSessionDataTask where Response: Decodable
    {
        var request = request
        request.setValue("Token \(apiKey)", forHTTPHeaderField: "Authorization")

        let task = session.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, error == nil else {
                completionHandler(.failure(.requestFailed(error as? URLError ?? URLError(.unknown))))
                return
            }

            switch response.statusCode {
            case 200:
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase

                do {
                    let response = try decoder.decode(Response.self, from: data ?? Data())
                    completionHandler(.success(response))
                } catch {
                    completionHandler(.failure(.unexpectedResponse(error)))
                }

            case 401:
                completionHandler(.failure(.unauthorized))

            case 403:
                completionHandler(.failure(.forbidden))

            case 404:
                completionHandler(.failure(.notFound))

            case 405:
                completionHandler(.failure(.methodNotAllowed))

            case 500:
                completionHandler(.failure(.internalServerError))

            case 502:
                completionHandler(.failure(.badGateway))

            case 503:
                completionHandler(.failure(.serviceUnavailable))

            default:
                completionHandler(.failure(.unknown))
            }
        }
        task.resume()
        return task
    }
}

extension KenallClient {
    @discardableResult
    open func address(postalCode: String,
                      using session: URLSession = .shared,
                      completionHandler: @escaping (Result<AddressResolverResponse, KenallError>) -> Void)
        -> URLSessionDataTask
    {
        let url = endpoint
            .appendingPathComponent("postalcode")
            .appendingPathComponent(postalCode)

        let request = URLRequest(url: url)

        return sendRequest(request, using: session, completionHandler: completionHandler)
    }
}
