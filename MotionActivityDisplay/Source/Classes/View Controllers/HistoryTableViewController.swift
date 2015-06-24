//
//  HistoryTableViewController.swift
//  MotionActivityDisplay
//
//  Created by Julian Grosshauser on 19/06/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit
import CoreMotion

class HistoryTableViewController: UITableViewController {

    //MARK: Properties

    private let motionActivityManager = CMMotionActivityManager()

    private var activities = [CMMotionActivity]() {
        didSet {
            tableView.reloadData()
        }
    }

    //MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "History"

        let closeButton = UIBarButtonItem(title: "Close", style: .Plain, target: self, action: "close:")
        navigationItem.leftBarButtonItem = closeButton
    }

    required init(coder aDecoder: NSCoder!) {
        super.init(coder: aDecoder)
    }

    //MARK: Button Actions

    @objc
    private func close(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}
