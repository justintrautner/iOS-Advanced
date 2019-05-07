//
//  PersonInfoController.swift
//  Star Wars Encyclopedia
//
//  Created by Justin Trautner on 5/6/19.
//  Copyright © 2019 Justin Trautner. All rights reserved.
//

import UIKit

class PersonInfoController: UIViewController {
    
    weak var delegate: personInfoDelegate?
    var personId: Int?
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var bdayLabel: UILabel!
    @IBOutlet weak var massLabel: UILabel!
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        delegate?.backButtonPressed(by: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        // Do any additional setup after loading the view.
    }
    
    func setUI(){
        if let id = personId{
            let uId = String(id + 1)
            let url = URL(string: "http://swapi.co/api/people/\(uId)")
            let session = URLSession.shared
            let task = session.dataTask(with: url!, completionHandler: {
                data, response, error in
                do{
                    if let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary{
                        print("json result is \(jsonResult)")
                        let personDict = jsonResult
                        DispatchQueue.main.async {
                            let name: String = personDict["name"]! as! String
                            self.nameLabel.text = name
//                            ???
                        }
                    }
                } catch{
                    print(error)
                }
            })
            task.resume()
        }
    }
    

}
