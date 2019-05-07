//
//  ViewController.swift
//  Star Wars Encyclopedia
//
//  Created by Justin Trautner on 5/2/19.
//  Copyright © 2019 Justin Trautner. All rights reserved.
//

import UIKit

class PeopleViewController: UITableViewController {
    
    var people = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        StarWarsModel.getAllPeople(completionHandler:{
            data, response, error in
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                    if let results = jsonResult["results"] {
                        let resultsArray = results as! NSArray
                        for person in resultsArray {
                            let personObj = person as! NSDictionary
                            self.people.append(personObj["name"] as! String)
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("something went wrong")
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        cell.textLabel?.text = people[indexPath.row]
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToDetail"{
            let infoController = segue.destination as! PersonInfoController
            infoController.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let personId = indexPath.row
        print("person id is \(personId)")
        performSegue(withIdentifier: "ToDetail", sender: personId)
    }
}

extension PeopleViewController: personInfoDelegate{
    
    func backButtonPressed(by controller: PersonInfoController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
}

