//
//  NetworkManager.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import Foundation

protocol NetworkManager: AnyObject {
    var serverError: NSError { get }
    
    func run(_ endpoint: RequestableProtocol, timeoutInterval: TimeInterval,  completion: @escaping (Result<ResultResponse, Error>) -> Void)
}

extension NetworkManager {
    
    var serverError: NSError {
        NSError(domain: #file, message: "Ocorreu uma instabilidade...")
    }
    
    
    func run(_ endpoint: RequestableProtocol, timeoutInterval: TimeInterval = 60, completion: @escaping (Result<ResultResponse, Error>) -> Void) {
        
        let url: URL = buildURL(endpoint)

        let config: URLSessionConfiguration = URLSessionConfiguration.default
        
        let session = URLSession.init(configuration: config)
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: timeoutInterval)
        request.httpMethod = endpoint.method.rawValue
        
        let task: URLSessionDataTask = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  let responseData: Data = data else {
                DispatchQueue.main.async {
                    if let error: NSError = error as NSError? {
                        let code: Int = (response as? HTTPURLResponse)?.statusCode ?? 0
                        let failure = NSError(domain: #file, message: error.localizedDescription, code: code, data: data)
                        self.log(error: failure, from: endpoint)
                        completion(.failure(failure))
                    } else {
                        self.log(error: self.serverError, from: endpoint)
                        completion(.failure(self.serverError))
                    }
                }
                return
            }
            let response: ResultResponse = ResultResponse(code: httpResponse.statusCode, data: responseData)
            self.log(response: response, from: endpoint)
            
            switch httpResponse.statusCode {
            case 200...299:
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            default:
                if let error: Error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                } else {
                    var errorMessage: String
                    if let json: [String: Any] = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments) as? [String: Any] {
                        if json.isEmpty {
                            errorMessage = "Nenhuma informação encontrado!"
                        } else {
                            errorMessage = self.serverError.localizedDescription
                        }
                    } else {
                        errorMessage = self.serverError.localizedDescription
                    }

                    let failure: NSError = NSError(domain: #file, message: errorMessage, code: httpResponse.statusCode, data: data)
                    DispatchQueue.main.async {
                        completion(.failure(failure))
                    }
                }
            }
        }
        self.log(request: endpoint)
        task.resume()
    }
}

//*************************************************
// MARK: - Private Methods
//*************************************************

extension NetworkManager {
    private func buildURL(_ endpoint: RequestableProtocol) -> URL {
        return endpoint.url
    }
    
    private func log(request: RequestableProtocol) {
        let url: URL = buildURL(request)

        print("\n")
        print("------------------------ REQUEST ------------------------")
        print("📤 \(request.method.rawValue) \(url.absoluteString)")
        
        print("---------------------- END REQUEST ----------------------")
    }
            
            
    private func log(response: ResultResponse, from request: RequestableProtocol) {
        
        let url: URL = buildURL(request)

        print("\n")
        print("------------------------ RESPONSE ------------------------")
        print("📥 [\(response.code)] \(request.method.rawValue) \(url.absoluteString)")
        
        if  let json: Any = try? JSONSerialization.jsonObject(with: response.data, options: .allowFragments),
            let pretty: Data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let string: NSString = NSString(data: pretty, encoding: String.Encoding.utf8.rawValue) {
            print("Data: \(string)")
        } else if let string = NSString(data: response.data, encoding: String.Encoding.utf8.rawValue) {
            print("Data: \(string)")
        }
        
        print("---------------------- END RESPONSE ----------------------")
    }
    
    private func log(error: NSError, code: Int = 0, from request: RequestableProtocol) {
        
        let url: URL = buildURL(request)

        print("\n")
        print("------------------------ RESPONSE ------------------------")
        print("📥 [\(String(code))] \(request.method.rawValue) \(url.absoluteString)")
        print("⚠️ Error: \(error)")
        
        if let reason = error.localizedFailureReason {
            print("Reason: \(reason)")
        }
        
        if let suggestion = error.localizedRecoverySuggestion {
            print("Suggestion: \(suggestion)")
        }
        print("---------------------- END RESPONSE ----------------------")
    }
}
