//
//  Subjects.swift
//  CWICW
//
//  Created by Jesus Vargas on 29/06/25.
//

import Foundation

struct Subjects: Decodable{
    let id: Int
    let id_subject: Int
    let description: String
    let id_type: Int
    let id_status: Int
    let created_by: Int
    let updated_by: Int
    let created_at: String
    let updated_at: String
}
