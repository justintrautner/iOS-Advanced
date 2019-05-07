//
//  StarWarsModel.swift
//  Star Wars Encyclopedia
//
//  Created by Justin Trautner on 5/4/19.
//  Copyright © 2019 Justin Trautner. All rights reserved.
//

import Foundation

class StarWarsModel{
    
    static func getAllPeople(completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let url = URL(string: "http://swapi.co/api/people/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
    }
    
    static func getAllFilms(completionHandler: @escaping (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void){
        let url = URL(string: "http://swapi.co/api/films/")
        let session = URLSession.shared
        let task = session.dataTask(with: url!, completionHandler: completionHandler)
        task.resume()
        }
    
}
