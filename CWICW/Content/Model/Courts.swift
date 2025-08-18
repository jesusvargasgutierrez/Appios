//
//  Schedules.swift
//  CWICW
//
//  Created by Jesus Vargas on 06/07/25.
//

import Foundation

struct Courts: Decodable{
    let id: Int
    let description: String
    let id_type_class:Int
    let id_status: String
    let created_by: Int
    let updated_by: Int
    let created_at: String
    let updated_at: String
}
