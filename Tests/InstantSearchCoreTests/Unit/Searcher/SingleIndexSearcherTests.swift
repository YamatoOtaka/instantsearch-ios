//
//  SingleIndexSearcherTests.swift
//  
//
//  Created by Vladislav Fitc on 03/08/2020.
//

import Foundation
import XCTest
@testable import InstantSearchCore

class SingleIndexSearcherTests: XCTestCase {
  
  func testOnQueryChanged() {
    let searcher = SingleIndexSearcher(appID: "", apiKey: "", indexName: "index1")
    let exp = expectation(description: "Query change expectation")
    searcher.onQueryChanged.subscribe(with: self) { (test, newQuery) in
      XCTAssertEqual(newQuery, "new query")
      exp.fulfill()
    }
    searcher.query = "new query"
    waitForExpectations(timeout: 2, handler: .none)
  }
  
  func testOnIndexChanged() {
    let searcher = SingleIndexSearcher(appID: "", apiKey: "", indexName: "index1")
    let exp = expectation(description: "Index change expectation")
    searcher.onIndexChanged.subscribe(with: self) { (test, indexName) in
      XCTAssertEqual(indexName, "index3")
      exp.fulfill()
    }
    searcher.indexQueryState.indexName = "index3"
    waitForExpectations(timeout: 2, handler: .none)
  }
  
  func testOnSearch() {
    let searcher = SingleIndexSearcher(appID: "", apiKey: "", indexName: "index1")
    let exp = expectation(description: "Search expectation")
    searcher.onSearch.subscribe(with: self) { (test, _) in
      exp.fulfill()
    }
    searcher.search()
    waitForExpectations(timeout: 2, handler: .none)
  }
  
  func testConditionalSearch() {
    let searcher = SingleIndexSearcher(appID: "", apiKey: "", indexName: "index1")
    let exp = expectation(description: "Search expectation")
    exp.isInverted = true
    searcher.onSearch.subscribe(with: self) { (test, _) in
      exp.fulfill()
    }
    searcher.shouldTriggerSearchForQuery = { query in return query.query ?? "" != "" }
    searcher.query = nil
    searcher.search()
    waitForExpectations(timeout: 2, handler: .none)
  }

}
