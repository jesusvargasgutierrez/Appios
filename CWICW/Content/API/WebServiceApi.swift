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
}
