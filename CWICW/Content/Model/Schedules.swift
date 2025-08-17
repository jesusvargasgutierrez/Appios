//
//  Schedules.swift
//  CWICW
//
//  Created by Jesus Vargas on 06/07/25.
//

import Foundation

struct Schedules: Decodable{
    let id: Int
    let description: String
    let day: String
    let month: String
    let year: String
    let day_description: String
    let month_description: String
    let hour_initial: String
    let hour_finish: String
    let time_hour: String
    let minuts: String
    let time_hour_initial: String
    let time_hour_finish: String
    let id_type_class: String
    let id_type_schedule: String
    let id_status: String
    let created_by: Int
    let updated_by: Int
    let created_at: String
    let updated_at: String
}
