//
//  WebServiceApi.swift
//  CWICW
//
//  Created by Jesus Vargas on 08/06/25.
//

import Alamofire

class WebServiceApi{
    
    static let shared = WebServiceApi()
    private let baseURL = "https://api.codersweb.com.mx/ws/"
    
    func gettypesubject(completion: @escaping (Result<[Subjects], Error>) ->Void){
        let url = baseURL + "listrecord"
        
        let parametros: [String: Any] = [
            "EndpointName": "subject",
        ]
        
        AF.request(url, method: .get, parameters: parametros, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: [Subjects].self){ response in
                /*if let data = response.data {
                    print("RAW JSON:")
                    print(String(data: data, encoding: .utf8) ?? "No es UTF-8 válido")
                }*/
                switch response.result{
                case .success(let data):
                    print("success")
                    completion(.success(data))
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                }
            }
    }
    
    func getschedules(completion: @escaping (Result<[Schedules], Error>) ->Void){
        let url = baseURL + "listrecord"
        
        let parametros: [String: Any] = [
            "EndpointName": "schedule",
        ]
        
        AF.request(url, method: .get, parameters: parametros, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: [Schedules].self){ response in
                /*if let data = response.data {
                    print("RAW JSON:")
                    print(String(data: data, encoding: .utf8) ?? "No es UTF-8 válido")
                }*/
                switch response.result{
                case .success(let data):
                    print("success")
                    completion(.success(data))
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                }
            }
    }
    
    func getcourts(completion: @escaping (Result<[Courts], Error>) ->Void){
        let url = baseURL + "listrecord"
        
        let parametros: [String: Any] = [
            "EndpointName": "court",
        ]
        
        AF.request(url, method: .get, parameters: parametros, encoding: URLEncoding.default)
            .validate()
            .responseDecodable(of: [Courts].self){ response in
                /*if let data = response.data {
                    print("RAW JSON:")
                    print(String(data: data, encoding: .utf8) ?? "No es UTF-8 válido")
                }*/
                switch response.result{
                case .success(let data):
                    print("success")
                    completion(.success(data))
                case .failure(let error):
                    print("error")
                    completion(.failure(error))
                }
            }
    }
    
    func login(username:String, password:String, completion: @escaping (Result<[Username], Error>) ->Void){
        let url = baseURL + "getrecordwhere"
        
        let parametros: [String: Any] = [
            "EndpointName": "users",
            "where": "[{\"username\": \"\(username)\"},{\"password\": \"\(password)\"}]"
        ]
        
        AF.request(url, method: .get, parameters: parametros, encoding: URLEncoding.queryString)
            .validate()
            .responseDecodable(of: LoginResponse.self){ response in
                switch response.result{
                case .success(let data):
                    print("success")
                    completion(.success(data.information))
                case .failure(let error):
                    print("error")
                    if let body = response.data {
                        print("Response body:", String(data: body, encoding: .utf8) ?? "nil")
                    }
                    completion(.failure(error))
                }
            }
    }
}
