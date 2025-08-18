import Foundation

struct Username: Codable{
    let id: Int
    let fname: String
    let lname: String
    let company: String
    let country: String
    let gender: Int
    let username: String
    let email: String
    let phone: String
    let birthday: String
    let password: String
    let id_status: Int
    let active: Int
    let remember_token: String?
    let created_at: String
    let updated_at: String
}
