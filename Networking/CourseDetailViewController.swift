//
//  CourseDetailViewController.swift
//  Networking
//
//  Created by Андрей Аверьянов on 05.01.2022.
//

import UIKit

class CourseDetailViewController: UIViewController {
    
    var course: Course!

    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        fetchCourse()
    }
    
    private func fetchCourse() {
        courseNameLabel.text = "\(course.name ?? "Not Found")"
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        DispatchQueue.global().async {
            guard let stringURL = self.course.imageUrl else {return}
            guard let imageURL = URL(string: stringURL) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}

            DispatchQueue.main.async {
                self.courseImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
