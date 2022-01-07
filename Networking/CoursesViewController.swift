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
        
    }
    
    func alamofirePostButtonPressed() {
        
    }
}
