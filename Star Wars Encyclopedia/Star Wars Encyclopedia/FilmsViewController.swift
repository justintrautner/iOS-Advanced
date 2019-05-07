//
//  FilmsViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Justin Trautner on 5/2/19.
//  Copyright © 2019 Justin Trautner. All rights reserved.
//

import UIKit

class FilmsViewController: UITableViewController {
    
    var films = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllFilms(completionHandler:{
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        for film in resultsArray {
                            let filmObj = film as! NSDictionary
                            self.films.append(filmObj["title"] as! String)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("error on films")
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = films[indexPath.row]
        return cell
    }

    

}
