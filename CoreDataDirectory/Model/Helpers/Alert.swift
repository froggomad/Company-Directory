//
//  Alert.swift
//  CoreData
//
//  Created by Kenny on 3/22/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

enum Alert {
    static func showBasic(title: String, message: String, viewController: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        viewController.present(alert, animated: true)
    }

//    static func saveEntry(vc: UIViewController) {
//        let alert = UIAlertController(title: "Calorie Entry",
//    message: "Enter the calories you want to track",
//    preferredStyle: .alert)
//        alert.addTextField { textField in
//            textField.placeholder = "Enter Calories"
//        }
//        alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { [weak alert] _ in
//            guard let text = alert?.textFields?[0].text,
//                let intValue = Int(text)
//                else { return }
//            _ = CalorieEntry(calories: intValue, date: Date())
//            do {
//                try CoreDataStack.shared.save()
//            } catch {
//                print("Error Saving from Alert Input: ", error)
//            }
//            NotificationCenter.default.post(name: .calorieEntryPosted, object: self)
//        }))
//        vc.present(alert, animated: true)
//    }
}
