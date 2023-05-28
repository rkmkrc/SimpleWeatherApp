//
//  Utils.swift
//  SimpleWeatherApp
//
//  Created by Erkam Karaca on 27.05.2023.
//

import Foundation
import UIKit

func getStringFromOptional(fromOptionalValue value: Any?, defaultString: String) -> String {
    if let unwrappedValue = value {
        return String(describing: unwrappedValue)
    } else {
        return defaultString
    }
}

func addBorder(to view: UIView, width: CGFloat, cornerRadius: CGFloat) {
    view.layer.borderWidth = width
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.cornerRadius = cornerRadius
    view.clipsToBounds = true
}


