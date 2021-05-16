//
//  SearchCityInteractorTests.swift
//  WeatherTests
//
//  Created by Ashirvad Jena on 15/05/21.
//

@testable import Weather
import XCTest

class SearchCityInteractorTests: XCTestCase {

    var sut: SearchCityInteractor?
    
    override func setUp() {
        super.setUp()
        sut = SearchCityInteractor()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testMapModelShouldConvertServerModelToWeatherModel() {
        let serverModel = SampleServerModel.getModel(for: "London")
        XCTAssertNil(sut?.weatherModel)
        sut?.mapServerModelToWeatherModel(serverModel)
        XCTAssertNotNil(sut?.weatherModel)
        XCTAssertEqual(sut?.weatherModel?.cityName, "London")
    }
    
    func testInteractorShouldPassNilToPresenterIfFetchFails() {
        sut?.presenter = SearchCityPresenterSpy()
        let request = SearchCityUseCases.FetchWeather.Request(searchCityName: "")
        sut?.fetchWeatherDetails(for: request)
        let expect = expectation(description: "Wait for fetchWeather to return")
        let waitSeconds = 2
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(waitSeconds)) {
            XCTAssertNil((self.sut?.presenter as! SearchCityPresenterSpy).weatherModel)
            expect.fulfill()
        }
        waitForExpectations(timeout: TimeInterval(waitSeconds))
    }
}

fileprivate class SearchCityPresenterSpy: SearchCityPresentationLogic {
    var weatherModel: WeatherModel?
    
    func presentResult(from response: SearchCityUseCases.FetchWeather.Response) {
        weatherModel = response.weatherModel
    }
    
    
}

