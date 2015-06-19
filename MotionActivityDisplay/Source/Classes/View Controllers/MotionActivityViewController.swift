//
//  MotionActivityViewController.swift
//  MotionActivityDisplay
//
//  Created by Julian Grosshauser on 19/06/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit
import CoreMotion

class MotionActivityViewController: UIViewController {

    //MARK: Properties

    private let motionActivityManager = CMMotionActivityManager()

    //MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        if (CMMotionActivityManager.isActivityAvailable()) {
            let historyButton = UIBarButtonItem(title: "History", style: .Plain, target: self, action: "showHistory:")
            navigationItem.leftBarButtonItem = historyButton
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: Button Actions

    @objc
    private func showHistory(sender: AnyObject) {
        presentViewController(UINavigationController(rootViewController: HistoryTableViewController()), animated: true, completion: nil)
    }
}
