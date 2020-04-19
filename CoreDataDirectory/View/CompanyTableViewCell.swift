//
//  CompanyTableViewCell.swift
//  CoreData
//
//  Created by Kenny on 3/22/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class CompanyTableViewCell: UITableViewCell {
    var company: Company? {
        didSet {
            setupCell()
        }
    }

    func setupCell() {
        let font = UIFont.boldSystemFont(ofSize: 16)
        guard let textLabel = textLabel,
            let company = company,
            let date = company.founded
        else { return }
        textLabel.font = font
        backgroundColor = .companyCellColor
        textLabel.textColor = .systemBackground
        print(company.name!)
        print("company founded: \(company.founded!)")
        textLabel.text = "Founded: \(Company.friendlyDate(date: date))"
    }
}
