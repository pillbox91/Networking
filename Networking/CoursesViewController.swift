//
//  CoursesViewController.swift
//  Networking
//
//  Created by Андрей Аверьянов on 04.01.2022.
//

import UIKit
import Alamofire

class CoursesViewController: UITableViewController {
    
    private var courses: [Course] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        courses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CourseCell

        let course = courses[indexPath.row]
        cell.configure(with: course)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let course = courses[indexPath.row]
        performSegue(withIdentifier: "showDetails", sender: course)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailsVC = segue.destination as? CourseDetailViewController else { return }
        
        detailsVC.course = sender as? Course
    }

}

// MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
//        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {return}
        guard let url = URL(string: URLExamples.exampleFive.rawValue) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
//            jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                self.courses = try jsonDecoder.decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
    
    func alamofireGetButtonPressed() {
        AF.request(URLExamples.exampleTwo.rawValue)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    
                    self.courses = Course.getCourses(from: value) ?? []
                    
//                    guard let coursesData = value as? [[String : Any]] else {return}
//
//                    for courseData in coursesData {
//                        let course = Course(
//                            name: courseData["name"] as? String,
//                            imageUrl: courseData["imageUrl"] as? String,
//                            numberOfLessons: courseData["number_of_lessons"] as? Int,
//                            numberOfTests: courseData["number_of_tests"] as? Int
//                        )
//
//                        self.courses.append(course)
//                    }
//
//                    for courseData in coursesData {
//                        let course = Course(courseData: courseData)
//                        self.courses.append(course)
//                    }
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func alamofirePostButtonPressed() {
        let courseData = [
            "name": "Networking",
            "imageUrl": "https://swiftbook.ru//wp-content/uploads/sites/2/2018/08/notifications-course-with-background.png",
            "numberOfLessonsPost": "18",
            "numberOfTestsPost": "10"
        ]
        
        AF.request(URLExamples.postRequest.rawValue, method: .post, parameters: courseData)
            .validate()
            .responseDecodable(of: Course.self) { dataResponse in
                switch dataResponse.result {
                case .success(let course):
                    self.courses.append(course)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                case .failure(let error):
                    print(error)
                }
            }
    }
}
