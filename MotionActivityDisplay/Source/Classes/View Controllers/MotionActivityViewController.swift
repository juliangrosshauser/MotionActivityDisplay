//
//  MotionActivityViewController.swift
//  MotionActivityDisplay
//
//  Created by Julian Grosshauser on 19/06/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit

class MotionActivityViewController: UIViewController {

    //MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        let historyButton = UIBarButtonItem(title: "History", style: .Plain, target: self, action: "showHistory:")
        navigationItem.leftBarButtonItem = historyButton
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: Button Actions

    @objc
    private func showHistory(sender: AnyObject) {

    }
}
