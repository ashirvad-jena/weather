# Weather
Weather app for iPhone written in Swift

## Installation
1. Open terminal. Type ```git clone https://github.com/ashirvad-jena/weather.git```
2. Go to the folder ``` cd Weather ```
3. Run ```pod install```
4. Open ```Weather.xcworkspace```

## Dependencies
1. ```RealmSwift```: Local storage
2. ```SDWebImage```: Download and cache image icons

## Structure
App consists of 3 scenes
1. Weather List: 
   * Displays the list of all cities and brief info on their weather
2. Search City: 
   * Search the city by name and add to the list
3. Weather Detail: 
   * Shows detail info about weather of a particular city

The app follows VIP (ViewController, Interactor, Presenter) architecture.<br/>
