//
//  MovieDetailViewController.swift
//  testOmdb
//
//  Created by shrutesh sharma on 29/03/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieName: UILabel!
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var movieDetails: UIView!
    @IBOutlet weak var plotLabel: UILabel!
    
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var movieItem:MovieItem?
    

    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.posterImage.alpha = 0
        self.scrollView.alpha = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.posterImage.image = DataManager.shared.posterImage(movieItem!)

        self.movieName.text = self.movieItem?.title
        self.year.text = self.movieItem?.year
        self.scrollView.delegate = self
        
        self.posterImage.image?.getColors { colors in
            self.view.backgroundColor = colors.backgroundColor
            self.dismissButton.tintColor = colors.primaryColor
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.scrollView.setContentOffset(CGPoint(x: 0, y: -500), animated: true)
    
        self.imageTopConstraint.constant = 30
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
            self.posterImage.fadeIn()
           
        }
        

        DataManager.shared.fetchMovieWithId(movieItem?.title ?? "") { (movie, error) in
            if let movie = movie {
                print(movie)
                self.plotLabel.text = movie.plot
                
                self.delay(1.0, closure: {
                    self.scrollView.alpha = 1
                    self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
                    self.movieDetails.addShadow(CGSize(width: 0.0, height: -2.0), cornerRadius: 5.0, shadowColor: UIColor.black.cgColor)
                })
                
            } else {
                print(error?.errorMessage ?? "" )
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dissmiss(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.imageTopConstraint.constant = 200
            self.view.layoutIfNeeded()
            self.posterImage.fadeOut()
        }) { (finished) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}


extension MovieDetailViewController : UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y / self.view.frame.size.height)
        
        let totalScroll = scrollView.contentSize.height - scrollView.bounds.size.height
        let offset = -scrollView.contentOffset.y
        let percentage = offset / totalScroll
        
        self.movieDetails.alpha = 0.5 - percentage
        
    }
}
