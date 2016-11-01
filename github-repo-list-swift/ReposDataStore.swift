//
//  FISReposDataStore.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import UIKit

class ReposDataStore {
    
    static let sharedInstance = ReposDataStore()

    
    var repositories: [GithubRepository] = [ ]
    
    private init() {}
    
    //get dictionaries, turn into repositories, append to array of GitHubRepositories. needs completion closure bc autocomplete.
    
    
    func getRepositoriesFromAPI(with completion: @escaping () -> ()) {
        
        repositories.removeAll()
        
        GithubAPIClient.getRepositories { repos in
            
            for dictionary in repos {
             
                let newRepo = GithubRepository(dictionary: dictionary)
                
               self.repositories.append(newRepo)
            
            }
            
            completion()
        
        }

        
    }
    
}




