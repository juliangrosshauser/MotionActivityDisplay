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

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()

        titleLabel.setTranslatesAutoresizingMaskIntoConstraints(false)

        if CMMotionActivityManager.isActivityAvailable() {
            titleLabel.text = "Current motion type:"
        } else {
            titleLabel.text = "Motion data isn't available on this device"
        }

        return titleLabel
    }()

    private let motionTypeLabel: UILabel = {
        let motionTypeLabel = UILabel()

        motionTypeLabel.setTranslatesAutoresizingMaskIntoConstraints(false)
        motionTypeLabel.numberOfLines = 0
        motionTypeLabel.textAlignment = .Center

        return motionTypeLabel
    }()

    //MARK: Initialization

    init() {
        super.init(nibName: nil, bundle: nil)

        title = "Motion Activity Display"

        if CMMotionActivityManager.isActivityAvailable() {
            let historyButton = UIBarButtonItem(title: "History", style: .Plain, target: self, action: "showHistory:")
            navigationItem.leftBarButtonItem = historyButton
        }
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    //MARK: UIViewController

    override func viewDidLoad() {
        view.addSubview(titleLabel)
        view.addSubview(motionTypeLabel)

        let verticalTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 0.5, constant: 0)
        let horizontalTitleConstraint = NSLayoutConstraint(item: titleLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)

        let verticalMotionTypeConstraint = NSLayoutConstraint(item: motionTypeLabel, attribute: .CenterY, relatedBy: .Equal, toItem: view, attribute: .CenterY, multiplier: 1, constant: 0)
        let horizontalMotionTypeConstraint = NSLayoutConstraint(item: motionTypeLabel, attribute: .CenterX, relatedBy: .Equal, toItem: view, attribute: .CenterX, multiplier: 1, constant: 0)

        view.addConstraints([verticalTitleConstraint, horizontalTitleConstraint, verticalMotionTypeConstraint, horizontalMotionTypeConstraint])
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        if CMMotionActivityManager.isActivityAvailable() {
            let motionActivityHandler: CMMotionActivityHandler = { [unowned self] activity in
                let motionTypes = join("\n", activity.motionTypes)

                self.motionTypeLabel.text = "\(motionTypes)\n\(activity.dateString)\n\(activity.confidenceString)"
            }

            motionActivityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: motionActivityHandler)
        }
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)

        if CMMotionActivityManager.isActivityAvailable() {
            motionActivityManager.stopActivityUpdates()
        }
    }

    //MARK: Button Actions

    @objc
    private func showHistory(sender: AnyObject) {
        presentViewController(UINavigationController(rootViewController: HistoryTableViewController()), animated: true, completion: nil)
    }
}
