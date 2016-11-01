//
//  GithubAPIClientSpec.swift
//  github-repo-list-swift
//
//  Created by  susan lovaglio on 10/23/16.
//  Copyright © 2016 Flatiron School. All rights reserved.
//

import Quick
import Nimble
import OHHTTPStubs

@testable import github_repo_list_swift

class GithubAPIClientSpec: QuickSpec {
    
    override func spec() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "repositories", ofType: "json") else { print("error getting the path"); return }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else { print("error getting data"); return }
        
        let repositoryArray = try! JSONSerialization.jsonObject(with: data, options: []) as! [[String : Any]]
        
        OHHTTPStubs.stubRequests(passingTest: { (request) -> Bool in
            return(request.url?.host == "api.github.com" && request.url?.path == "/repositories")
            
        }) { (request) -> OHHTTPStubsResponse in
            return OHHTTPStubsResponse(fileAtPath: OHPathForFileInBundle("repositories.json", Bundle(for: type(of: self)))!, statusCode: 200, headers: ["Content-Type" : "application/jason"])
        }
        
        
        describe("getRepositories") {
            it("should get the proper repositories from Github") {
                waitUntil(action: { (done) in
                    
                    GithubAPIClient.getRepositories(with: { repos in
                        
                        expect(repos).toNot(beNil())
                        expect(repos.count).to(equal(2))
                        
                        let repo1Name = repositoryArray[0]["full_name"] as? String
                        let repo2Name = repositoryArray[0]["full_name"] as? String
                        expect(repo1Name).to(equal(repo2Name))
                        
                        done()
                    })
                })
            }
        }
    }
}
