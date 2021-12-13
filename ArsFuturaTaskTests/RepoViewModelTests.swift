//
//  RepoViewModelTests.swift
//  ArsFuturaTaskTests
//
//  Created by Hrvoje Vuković on 13.12.2021..
//

import XCTest
@testable import ArsFuturaTask

class RepoViewModelTests: XCTestCase {
    
    var repoViewModel: RepoViewModel!
    
    override func setUp() {
        super.setUp()
        
        let user = Users(login: "mojombo", id: 1, avatarUrl: "https://avatars.githubusercontent.com/u/1?v=4", htmlUrl: "https://github.com/mojombo")
        
        let repo = Repo(name: "30daysoflaptops.github.io", htmlUrl: "https://github.com/mojombo/30daysoflaptops.github.io", description: nil, createdAt: "2014-11-20T06:42:06Z", forks: 2)
        
        repoViewModel = RepoViewModel(user, repo)
    }
    
    override func tearDown() {
        repoViewModel = nil
        super.tearDown()
    }
    
    func testRepoViewModelInit() {
        let repoViewModelMirror = Mirror(reflecting: repoViewModel as Any)
        XCTAssertNotNil(repoViewModelMirror)
    }
    
    func testGetUserData() {
        let getUserDataMirror = Mirror(reflecting: repoViewModel.getUserData())
        XCTAssertNotNil(getUserDataMirror)
    }
    
    func testGetRepoDataName() {
        XCTAssertEqual(repoViewModel.getRepoData(for: .repoName), "30daysoflaptops.github.io")
    }
    
    func testGetRepoDataDescription() {
        XCTAssertEqual(repoViewModel.getRepoData(for: .description), Optional(""))
    }
    
    func testGetRepoDataCreatedDate() {
        XCTAssertEqual(repoViewModel.getRepoData(for: .createdDate), "20.11.2014.")
    }

    func testGetRepoDataRepoUrl() {
        XCTAssertEqual(repoViewModel.getRepoData(for: .repoUrl), "https://github.com/mojombo/30daysoflaptops.github.io")
    }

    func testGetRepoDataForks() {
        XCTAssertEqual(repoViewModel.getRepoData(for: .forks), "2")
    }
    
    func testGetRepoName() {
        XCTAssertEqual(repoViewModel.getRepoName(), "30daysoflaptops.github.io")
    }
    
    func testGetNumberOfOptions() {
        XCTAssertEqual(repoViewModel.getNumberOfOptions(inSection: 0), 2)
        XCTAssertEqual(repoViewModel.getNumberOfOptions(inSection: 1), 3)
    }
    
    func testGetOptionForSection() {
        XCTAssertEqual(repoViewModel.getOptionForSection(at: IndexPath(row: 0, section: 0)), Options(rawValue: 0))
    }
    
    func testGetSectionCount() {
        XCTAssertEqual(repoViewModel.getSectionCount(), 2)
    }
}
