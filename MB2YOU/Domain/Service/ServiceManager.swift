//
//  ServiceManager.swift
//  MB2YOU
//
//  Created by Vinicius Alencar on 9/21/21.
//

import Foundation

protocol ServiceManagerProtocol {
    /// - Parameter
    /// endpoint: Contains request information
    /// model: Model to parse return data
    /// completion: Completion closure with a Result object.
    func request<T>(_ endpoint: RequestableProtocol, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T: Decodable
}

class ServiceManager: ServiceManagerProtocol, NetworkManager {
    
    //*************************************************
    // MARK: - Inits
    //*************************************************
    
    init() { }
}

//*************************************************
// MARK: - Public Methods
//*************************************************

extension ServiceManager {
    func request(_ endpoint: RequestableProtocol, completion: @escaping (Result<Data, Error>)-> Void) {
        run(endpoint) { result in
            switch result {
            case .success(let response):
                completion(.success(response.data))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func request<T>(_ endpoint: RequestableProtocol, model: T.Type, completion: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        request(endpoint) { result in
            switch result {
            case .success(let data):
                do {
                    let object: T = try JSONDecoder().decode(model, from: data)
                    completion(.success(object))
                } catch DecodingError.dataCorrupted(let context) {
                    print(context)
                    let error: NSError = NSError(domain: #file, code: -1, message: context.debugDescription)
                    completion(.failure(error))
                } catch DecodingError.keyNotFound(let key, let context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let error: NSError = NSError(domain: #file, code: -1, message: context.debugDescription)
                    completion(.failure(error))
                } catch DecodingError.valueNotFound(let value, let context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let error: NSError = NSError(domain: #file, code: -1, message: context.debugDescription)
                    completion(.failure(error))
                } catch DecodingError.typeMismatch(let type, let context) {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                    let error: NSError = NSError(domain: #file, code: -1, message: context.debugDescription)
                    completion(.failure(error))
                } catch {
                    print(error)
                    completion(.failure(error))
                }
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
}
