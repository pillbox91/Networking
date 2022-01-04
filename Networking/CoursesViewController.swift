//
//  CoursesViewController.swift
//  Networking
//
//  Created by Андрей Аверьянов on 04.01.2022.
//

import UIKit

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

}

// MARK: - Networking
extension CoursesViewController {
    func fetchCourses() {
        guard let url = URL(string: URLExamples.exampleTwo.rawValue) else {return}
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {return}
            let jsonDecoder = JSONDecoder()
            
            do {
                self.courses = try jsonDecoder.decode([Course].self, from: data)
            } catch let error {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}
