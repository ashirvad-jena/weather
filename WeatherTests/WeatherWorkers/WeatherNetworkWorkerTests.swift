//
//  WeatherNetworkWorkerTests.swift
//  WeatherTests
//
//  Created by Ashirvad Jena on 15/05/21.
//

@testable import Weather
import XCTest

class WeatherNetworkWorkerTests: XCTestCase {
    
    var sut: WeatherNetworkWorker!

    override func setUp() {
        super.setUp()
        sut = WeatherNetworkWorker(cityWeather: FetchCityWeatherSpy())
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testFetchWeatherShouldreturnServerWeatherModel() {
        let fetchWeatherSpy = sut.cityWeather as! FetchCityWeatherSpy
        XCTAssertFalse(fetchWeatherSpy.didFetchResult)
        let expect = expectation(description: "Wait for fetchWeather to return")
        sut.cityWeather?.fetchWeatherFromApi(for: "London", completionHandler: { serverWeatherModel in
            XCTAssertTrue(fetchWeatherSpy.didFetchResult)
            XCTAssertNotNil(serverWeatherModel)
            expect.fulfill()
        })
        waitForExpectations(timeout: 2.1)
    }
    
    func testFetchWeatherForEmptyStringShouldReturnNil() {
        let fetchWeatherSpy = sut.cityWeather as! FetchCityWeatherSpy
        XCTAssertFalse(fetchWeatherSpy.didFetchResult)
        let expect = expectation(description: "Wait for fetchWeather to return")
        sut.cityWeather?.fetchWeatherFromApi(for: "", completionHandler: { serverWeatherModel in
            XCTAssertFalse(fetchWeatherSpy.didFetchResult)
            XCTAssertNil(serverWeatherModel)
            expect.fulfill()
        })
        waitForExpectations(timeout: 2.1)
    }
}

fileprivate class FetchCityWeatherSpy: FetchCityWeatherProtocol {
    
    var didFetchResult = false
    
    func fetchWeatherFromApi(for searchName: String, completionHandler: @escaping (ServerWeatherModel?) -> Void) {
        guard !searchName.isEmpty else {
            completionHandler(nil)
            return
        }
        let serverWeatherModel = SampleServerModel.getModel(for: searchName)
        // Mock server api call
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.didFetchResult = true
            completionHandler(serverWeatherModel)
        }
    }
}
