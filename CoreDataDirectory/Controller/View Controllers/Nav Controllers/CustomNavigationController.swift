//
//  CustomNavigationController.swift
//  CoreData
//
//  Created by Kenny on 3/19/20.
//  Copyright © 2020 Hazy Studios. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {
    //=======================
    // MARK: - View Lifecycle

    override var preferredStatusBarStyle: UIStatusBarStyle {
        setStatusBar(backgroundColor: .lightRed)
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    private func setupViews() {
        setupNavBar()
    }

    //=======================
    // MARK: - NavBar
    private func setupNavBar() {
        setBarTint()
        setTitleAttributes()
    }

    private func setBarTint() {
        navigationBar.backgroundColor = .lightRed
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = .lightRed
        navigationBar.tintColor = .systemBackground
    }

    func setTitleAttributes() {
        navigationBar.prefersLargeTitles = true
        navigationBar
            .largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar
        .titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }

    //=======================
    // MARK: - Status Bar
    func setStatusBar(backgroundColor: UIColor) {
        let statusBarFrame: CGRect
        if #available(iOS 13.0, *) {
            statusBarFrame = view.window?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            statusBarFrame = UIApplication.shared.statusBarFrame
        }
        let statusBarView = UIView(frame: statusBarFrame)
        statusBarView.backgroundColor = backgroundColor
        view.addSubview(statusBarView)
    }
}
