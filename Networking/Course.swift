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
    let numberOfLessonsPost: String?
    let numberOfTestsPost: String?
    
    //    enum CodingKeys: String, CodingKey {
    //        case name = "Name"
    //        case imageUrl = "ImageUrl"
    //        case numberOfLessons = "Number_of_lessons"
    //        case numberOfTests = "Number_of_tests"
    //    }
    
    init(courseData: [String : Any]) {
        name = courseData["name"] as? String
        imageUrl = courseData["imageUrl"] as? String
        numberOfLessons = courseData["number_of_lessons"] as? Int
        numberOfTests = courseData["number_of_tests"] as? Int
        numberOfLessonsPost = courseData["number_of_lessons"] as? String
        numberOfTestsPost = courseData["number_of_tests"] as? String
    }
    
    static func getCourses(from value: Any) -> [Course]? {
        guard let coursesData = value as? [[String : Any]] else {return []}
        return coursesData.compactMap { Course(courseData: $0) }
        
//        var courses: [Course] = []
//
//        for courseData in coursesData {
//            let course = Course(courseData: courseData)
//            courses.append(course)
//        }
//
//        return courses
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
