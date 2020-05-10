//
//  AnimalCherish_iOSTests.swift
//  AnimalCherish_iOSTests
//
//  Created by Cagatay Ozata on 6.05.2020.
//  Copyright © 2020 CTIS_Team1. All rights reserved.
//

import Alamofire
import XCTest

struct Configuration {
    static let apiUrl = "http://138.68.67.165"
}

class AnimalUnit: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getTest() throws {
        let tempApiUrl = Configuration.apiUrl + "/api/v1/animal/getall"

        AF.request(tempApiUrl, method: .get).responseJSON { myresponse in

            XCTAssertNil(myresponse.error, "Whoops, error \(myresponse.error!.localizedDescription)")
            XCTAssertNotNil(myresponse, "No response")
            XCTAssertEqual(myresponse.response?.statusCode ?? 0, 200, "Status code not 200")
        }
    }
}

class PetShopUnit: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getTest() throws {
        let tempApiUrl = Configuration.apiUrl + "/api/v1/petshop/getall"

        AF.request(tempApiUrl, method: .get).responseJSON { myresponse in

            XCTAssertNil(myresponse.error, "Whoops, error \(myresponse.error!.localizedDescription)")
            XCTAssertNotNil(myresponse, "No response")
            XCTAssertEqual(myresponse.response?.statusCode ?? 0, 200, "Status code not 200")
        }
    }
}

class ShelterUnit: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getTest() throws {
        let tempApiUrl = Configuration.apiUrl + "/api/v1/shelter/getall"

        AF.request(tempApiUrl, method: .get).responseJSON { myresponse in

            XCTAssertNil(myresponse.error, "Whoops, error \(myresponse.error!.localizedDescription)")
            XCTAssertNotNil(myresponse, "No response")
            XCTAssertEqual(myresponse.response?.statusCode ?? 0, 200, "Status code not 200")
        }
    }
}

class VetUnit: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getTest() throws {
        let tempApiUrl = Configuration.apiUrl + "/api/v1/vet/getall"

        AF.request(tempApiUrl, method: .get).responseJSON { myresponse in

            XCTAssertNil(myresponse.error, "Whoops, error \(myresponse.error!.localizedDescription)")
            XCTAssertNotNil(myresponse, "No response")
            XCTAssertEqual(myresponse.response?.statusCode ?? 0, 200, "Status code not 200")
        }
    }
}

class ZooUnit: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func getTest() throws {
        let tempApiUrl = Configuration.apiUrl + "/api/v1/zoo/getall"

        AF.request(tempApiUrl, method: .get).responseJSON { myresponse in

            XCTAssertNil(myresponse.error, "Whoops, error \(myresponse.error!.localizedDescription)")
            XCTAssertNotNil(myresponse, "No response")
            XCTAssertEqual(myresponse.response?.statusCode ?? 0, 200, "Status code not 200")
        }
    }
}
