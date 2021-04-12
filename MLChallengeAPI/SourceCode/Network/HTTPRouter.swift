//
//  HTTPRouter.swift
//  MLChallengeAPI
//
//  Created by Miguel Angel De Leon Palacios on 06/04/21.
//

import Foundation

/**
 Class to send requests.
 */
final class HTTPRouter {
    // MARK - Properties
    private let bodyEncoder: JSONEncoder
    private let responseDecoder: JSONDecoder
    private let urlSession: URLSession
    typealias constants = ServicesConstants

    var baseURL: String
    weak var headersProvider: HeadersProvider?

    init(baseURL: String,
         urlSession: URLSession,
         bodyEncoder: JSONEncoder = .init(),
         responseDecoder: JSONDecoder = .init()) {
        self.baseURL = baseURL
        self.bodyEncoder = bodyEncoder
        self.responseDecoder = responseDecoder
        self.urlSession = urlSession
    }
    
    // MARK: - Functions.
    
    /**
     Create a URLRequest.
     - Parameter request: generic request with all values to send.
     - Returns: new URLRequest object.
     */
    private func createURLRequest<Request: HTTPRequest>(for request: Request) throws -> URLRequest {
        guard let url = URL(string: baseURL + request.endpoint) else {
            throw ServicesResponseError.urlBadFormat
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.cachePolicy = .reloadIgnoringCacheData
        urlRequest.setValue(constants.contentTypeValue, forHTTPHeaderField: constants.contentTypeKey)
        let headers = (self.headersProvider?.getHeaders() ?? [:]).merging(request.headers) { $1 }
        headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }

        if let body = request.body,
           let httpBody = try? bodyEncoder.encode(body) {
            urlRequest.httpBody = httpBody
        }

        return urlRequest
    }
    
    /**
     Decode the response received and check if this object can be decoded, create a new responseFactory object.
     - Parameter request: current request.
     - Parameter urlRequest: current URLRequest object.
     - Parameter httpResponse:object represents a response to an HTTP URL load.
     - Parameter data: data received.
     - Parameter error: posible error received.
     - Returns: custom HTTPResponse object.
     */
    func decodeResponse<Request: HTTPRequest>(request: Request, urlRequest: URLRequest, httpResponse: HTTPURLResponse?, data: Data?, error: Error?) -> HTTPResponse<Request.Response> {
        let responseFactory = HTTPResponseFactory<Request>()
        responseFactory.urlRequest = urlRequest
        responseFactory.httpResponse = httpResponse

        switch (error: error, data: data) {
        case (error: .some(let requestError), data: _):
            return responseFactory.createFailResponse(error: .httpError(error: requestError))
        case (error: .none, data: .some(let responseData)):
            do {
                let decodedResponse = try responseDecoder.decode(Request.Response.self, from: responseData)
                return responseFactory.createSuccessResponse(response: decodedResponse)
            } catch let error {
                let json = (try? JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]) ?? [:]
                print("[DEBUG] ERROR RECEIVED: \n \(error) \n [DEBUG] WHILE PARSING: \n \(json)")
                return responseFactory.createFailResponse(error: .badResponseCodification(error: error))
            }
        case (error: .none, data: .none):
            return responseFactory.createFailResponse(error: .serverError)
        }
    }
    
    /**
     Build a response by status code received.
     - Parameter statusCode: request status code.
     - Parameter request: current request.
     - Parameter responseFactory: build a reponse.
     - Parameter error: posible error received.
     - Parameter data: data received.
     - Returns: custom HTTPResponse object.
     */
    func getResponseBy<Request>(statusCode: Int, request: Request, responseFactory: HTTPResponseFactory<Request>, error: Error?, data: Data?) -> HTTPResponse<Request.Response> {
        guard let urlRequest = responseFactory.urlRequest else {
            return responseFactory.createFailResponse(error: .urlBadFormat)
        }
        switch statusCode {
        case constants.httpCodeSuccessRange:
            return self.decodeResponse(request: request,
                                       urlRequest: urlRequest,
                                       httpResponse: responseFactory.httpResponse,
                                       data: data,
                                       error: error)
        case constants.httpBadRequest, constants.httpResourceNotFound:
            return responseFactory.createFailResponse(error: .httpError(error: error))
        case constants.httpAuthorizationErrorRange:
            return responseFactory.createFailResponse(error: .authorizationError)
        default:
            return responseFactory.createFailResponse(error: .serverError)
        }
    }
}

// MARK: - HTTPClient implementation
extension HTTPRouter: HTTPClient {
    
    /**
     Function to execute request.
     - Parameter request: object with all values to send request.
     - Parameter completion: Completion to return response.
     */
    func execute<Request>(request: Request, completion: @escaping (HTTPResponse<Request.Response>) -> Void) where Request : HTTPRequest {
        let responseFactory = HTTPResponseFactory<Request>()
        
        do {
            let urlRequest = try createURLRequest(for: request)
            let task = self.urlSession.dataTask(with: urlRequest) { [weak self] data, urlResponse, error in
                responseFactory.urlRequest = urlRequest
                guard let self = self, let httpResponse = urlResponse as? HTTPURLResponse else {
                    let noInternetConnection = (error as NSError?)?.code == NSURLErrorNotConnectedToInternet
                    completion(responseFactory.createFailResponse(error: noInternetConnection ? .noInternetConnection : .unknown))
                    return
                }
                responseFactory.httpResponse = httpResponse
                completion(self.getResponseBy(statusCode: httpResponse.statusCode,
                                              request: request,
                                              responseFactory: responseFactory,
                                              error: error,
                                              data: data))
            }
            task.resume()
        } catch {
            completion(responseFactory.createFailResponse(error: (error as? ServicesResponseError) ?? .unknown))
        }
    }
}

// MARK: - Cancellable implementation.
extension URLSessionTask: Cancellable {}
