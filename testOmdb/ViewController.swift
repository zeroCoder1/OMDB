//
//  ViewController.swift
//  testOmdb
//
//  Created by shrutesh sharma on 19/02/17.
//  Copyright © 2017 Singularity. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var collapsibleView: SSCollapsibleView!
    @IBOutlet weak var collapsibleViewHeightConstraint: NSLayoutConstraint!
    var moviesSearch:SearchMovie?
    var dataArray = [MovieItem]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.red

        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "customCell")
        self.textField.returnKeyType = .search
        self.textField.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.collapsibleView.maxHeight = 75
        self.collapsibleView.minHeight = 0
        self.collapsibleView.heightConstraint = self.collapsibleViewHeightConstraint
        self.collapsibleView.attachToScrollView(self.tableView, inset: 0)
        
//        tableView.layer.zPosition = -1;
//        var transform:CATransform3D = CATransform3DIdentity
//        transform.m34 = 1.0 / -450
//        
//        transform = CATransform3DRotate(transform, CGFloat(45.0 * M_PI / 165.0), 1.0, 0.0, 0.0)
//        transform = CATransform3DScale(transform, 1, 1.1, 1.1)
//        transform = CATransform3DTranslate(transform, 0, 0, 150)
//        self.tableView.layer.transform = transform
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let path = self.tableView.indexPathForSelectedRow
        guard let movie:MovieItem = self.moviesSearch?.getResults()[path?.item ?? 0] else {
            return
        }
        
        (segue.destination as! MovieDetailViewController).movieItem = movie
    }
    
    func delay(_ delay: Double, closure: @escaping () -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            closure()
        }
    }
}



extension ViewController : UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let moviesSearch = moviesSearch {
            return moviesSearch.getResults().count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
        guard let movieSearch = self.moviesSearch else { return UITableViewCell() }
        
        let movie:MovieItem = movieSearch.getResults()[indexPath.row]

        cell.movieName?.text = movie.title
        cell.movieImage?.image = DataManager.shared.posterImage(movie)
        cell.year?.text = movie.year
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delay(0) { 
            self.performSegue(withIdentifier: "detail", sender: self.view)
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let localItemsCount = tableView.numberOfRows(inSection: 0)
        if indexPath.row == localItemsCount - 1 {
            
            if let moviesSearch = moviesSearch {
                moviesSearch.fecthNextPage(onCompletion: { error in
                    DispatchQueue.main.async(execute: {
                        self.tableView.reloadData()
                    })
                })
            }
        }
    }
}

extension ViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        self.textField.resignFirstResponder()
        if(moviesSearch == nil || moviesSearch?.getKeyword() != textField.text) {
            self.moviesSearch = SearchMovie(keyword: self.textField.text ?? "")
            self.moviesSearch?.fecthNextPage(onCompletion: { error in
                
                DispatchQueue.main.async(execute: {
                    let range = NSMakeRange(0, self.tableView.numberOfSections)
                    let sections = NSIndexSet(indexesIn: range)
                    self.tableView.reloadSections(sections as IndexSet, with: .fade)
                    self.tableView.reloadData()
                })
            })
        }
        return true
    }
}

extension ViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.collapsibleView.scrollViewDidScroll(scrollView)
    }
    
}

extension UINavigationController {
    
    public func presentTransparentNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = true
        navigationBar.shadowImage = UIImage()
        setNavigationBarHidden(false, animated:true)
    }
    
    public func hideTransparentNavigationBar() {
        setNavigationBarHidden(true, animated:false)
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.isTranslucent = UINavigationBar.appearance().isTranslucent
        navigationBar.shadowImage = UINavigationBar.appearance().shadowImage
    }
}
