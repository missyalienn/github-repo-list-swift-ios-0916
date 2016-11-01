//
//  FISGithubAPIClient.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class GithubAPIClient {
    
    
    
    typealias JSON = [String : AnyObject]
    
    static func getRepositories(with completion: @escaping ([JSON]) -> Void) {
    
    
    let urlString = "https://api.github.com/repositories?client_id=249fc94b4d6557a9c35a&client_secret=c86ebcd91b3f6f50d87d3db035c5c4f06e0e2149"
    
    let url = URL(string: urlString)
     
    if let unwrappedURL = url {
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: unwrappedURL, completionHandler: { (data, response, error) in
            
            if let unwrappedData = data {
                
                do {
                   // handle error with try
                    let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [JSON]
                    
                    print(responseJSON)
                    completion(responseJSON)
                 
                }catch{
                    
                   //hey api not working
                    print(error)
                    
                }
            }
          
        })
        
        task.resume()
        
    }
        
    }




    
    
    
    
    
    
    
}
