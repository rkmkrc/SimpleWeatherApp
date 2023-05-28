//
//  DetailScreen.swift
//  SimpleWeatherApp
//
//  Created by Erkam Karaca on 26.05.2023.
//

import Foundation
import UIKit

class DetailScreen: UIViewController {
    
    @IBOutlet weak var humidityView: UIView!
    @IBOutlet weak var windView: UIView!
    @IBOutlet weak var seaLevelView: UIView!
    @IBOutlet weak var coordinatesView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minMaxTemperatureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windGustLabel: UILabel!
    @IBOutlet weak var seaLevelLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    
    var city: City?
    var cityID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCity(id: self.cityID)
        addBorder(to: humidityView, width: 1.0, cornerRadius: 10)
        addBorder(to: windView, width: 1.0, cornerRadius: 10)
        addBorder(to: seaLevelView, width: 1.0, cornerRadius: 10)
        addBorder(to: coordinatesView, width: 1.0, cornerRadius: 10)
    }
    
    func getCity(id: String?) {
        if let url = NetworkManager.shared.getWeatherURL(forID: id ?? "") {
            fetchData(from: url, expecting: City.self) { result in
                switch result {
                case .success(let city):
                    DispatchQueue.main.async {
                        self.city = city
                        self.configureView()
                    }
                case .failure(let error):
                    print(MyError.DATA_ERROR + " \(error)")
                }
            }
        }
    }
    
    func configureView() {
        let cityName = getStringFromOptional(fromOptionalValue: self.city?.name, defaultString: Constants.placeholderCityName)
        let currentTemp = getStringFromOptional(fromOptionalValue: self.city?.main?.temp, defaultString: Constants.placeholderTemperature)
        let feelsLike = getStringFromOptional(fromOptionalValue: self.city?.main?.feelsLike, defaultString: Constants.placeholderTemperature)
        let maxTemp = getStringFromOptional(fromOptionalValue: self.city?.main?.tempMax, defaultString: Constants.placeholderTemperature)
        let minTemp = getStringFromOptional(fromOptionalValue: self.city?.main?.tempMin, defaultString: Constants.placeholderTemperature)
        let humidity = getStringFromOptional(fromOptionalValue: self.city?.main?.humidity, defaultString: Constants.placeholderHumidity)
        let windSpeed = getStringFromOptional(fromOptionalValue: self.city?.wind?.speed, defaultString: Constants.placeholderSpeed)
        let gust = getStringFromOptional(fromOptionalValue: self.city?.wind?.gust, defaultString: Constants.placeholderGust)
        let seaLevel = getStringFromOptional(fromOptionalValue: self.city?.main?.seaLevel, defaultString: Constants.placeholderSeaLevel)
        let longitude = getStringFromOptional(fromOptionalValue: self.city?.coord?.lon, defaultString: Constants.placeholderLon)
        let latitude = getStringFromOptional(fromOptionalValue: self.city?.coord?.lat, defaultString: Constants.placeholderLat)
        let description = getStringFromOptional(fromOptionalValue: self.city?.weather?[0].description, defaultString: Constants.placeholderWeatherDescription)

        cityNameLabel.text = cityName
        currentTemperatureLabel.text = "Current: \(currentTemp) C"
        feelsLikeLabel.text = "Feels Like: \(feelsLike) C"
        minMaxTemperatureLabel.text = "H: \(maxTemp) C L: \(minTemp) C"
        humidityLabel.text = "%\(humidity)"
        windSpeedLabel.text = "Speed: \(windSpeed) km/h"
        windGustLabel.text = "Gust: \(gust) km/h"
        seaLevelLabel.text = seaLevel
        latitudeLabel.text = "Latitude: \(latitude)"
        longitudeLabel.text = "Longitude: \(longitude)"
        weatherDescriptionLabel.text = "Description: \(description)"
    }
}



