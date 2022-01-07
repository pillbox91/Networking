//
//  CourseCell.swift
//  Networking
//
//  Created by Андрей Аверьянов on 04.01.2022.
//

import UIKit

class CourseCell: UITableViewCell {
    
    @IBOutlet var courseImage: UIImageView!
    @IBOutlet var courseNameLabel: UILabel!
    @IBOutlet var numberOfLessons: UILabel!
    @IBOutlet var numberOfTests: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    func configure(with course: Course) {
        courseNameLabel.text = course.name
        numberOfLessons.text = "Number of lessons: \(course.numberOfLessons ?? 0)"
        numberOfTests.text = "Number of tests: \(course.numberOfTests ?? 0)"
        
        DispatchQueue.global().async {
            guard let stringURL = course.imageUrl else {return}
            guard let imageURL = URL(string: stringURL) else {return}
            guard let imageData = try? Data(contentsOf: imageURL) else {return}
            
            DispatchQueue.main.async {
                self.courseImage.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
