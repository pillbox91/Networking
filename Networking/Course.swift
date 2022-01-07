//
//  Course.swift
//  Networking
//
//  Created by Андрей Аверьянов on 04.01.2022.
//

struct Course: Codable {
    let name: String?
    let imageUrl: String?
    let numberOfLessons: Int?
    let numberOfTests: Int?
    
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case imageUrl = "ImageUrl"
        case numberOfLessons = "Number_of_lessons"
        case numberOfTests = "Number_of_tests"
    }
}

struct CourseData: Codable {
    let name: String
    let imageUrl: String
    let numberOfLessons: String
    let numberOfTests: String
}

struct WebsiteDescription: Decodable {
    let courses: [Course]?
    let websiteDescription: String?
    let websiteName: String?
}
