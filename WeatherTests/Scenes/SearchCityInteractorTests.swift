//
//  SearchCityInteractorTests.swift
//  WeatherTests
//
//  Created by Ashirvad Jena on 15/05/21.
//

@testable import Weather
import XCTest

class SearchCityInteractorTests: XCTestCase {

    var sut: SearchCityInteractor!
    
    override func setUp() {
        super.setUp()
        sut = SearchCityInteractor()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testMapModelShouldConvertServerModelToWeatherModel() {
        let serverModel = SampleServerModel.getModel(for: "London")
        XCTAssertNil(sut.weatherModel)
        sut.mapServerModelToWeatherModel(serverModel)
        XCTAssertNotNil(sut.weatherModel)
        XCTAssertEqual(sut.weatherModel?.cityName, "London")
    }
}

