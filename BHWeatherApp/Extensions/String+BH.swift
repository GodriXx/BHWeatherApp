//
//  String+BH.swift
//  BHWeatherApp
//
//  Created by Bassem Hatira on 19/01/2021.
//

import Foundation

extension String {
    
    // Return the appropriate value for string key from localizable files, using device language
    var localized: String {
        guard let bundle = Bundle.main.path(forResource: String(Locale.preferredLanguages.first?.prefix(2) ?? "en"),
                                            ofType: "lproj") else {
            return NSLocalizedString(self, comment: self)
        }
        
        let langBundle = Bundle(path: bundle)
        return NSLocalizedString(self, tableName: nil, bundle: langBundle!, comment: self)
    }
}
