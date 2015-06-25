//
//  HistoryTableViewController.swift
//  MotionActivityDisplay
//
//  Created by Julian Grosshauser on 19/06/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import UIKit
import CoreMotion

class HistoryTableViewCell: UITableViewCell {

    //MARK: Initialization

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .Subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

class HistoryTableViewController: UITableViewController {

    //MARK: Properties

    private let motionActivityManager = CMMotionActivityManager()
    private let cellIdentifier = "historyCell"

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

    //MARK: UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.registerClass(HistoryTableViewCell.self, forCellReuseIdentifier: cellIdentifier)

        if CMMotionActivityManager.isActivityAvailable() {
            let now = NSDate()
            let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
            let lastWeek = calendar.dateByAddingUnit(.CalendarUnitDay, value: -1, toDate: now, options: .allZeros)

            let motionActivityQueryHandler: CMMotionActivityQueryHandler = { [unowned self] (activities: [AnyObject]!, error: NSError!) in
                if let activities = activities as? [CMMotionActivity] where error == nil {
                    self.activities = activities
                }
            }

            motionActivityManager.queryActivityStartingFromDate(lastWeek, toDate: now, toQueue: NSOperationQueue.mainQueue(), withHandler: motionActivityQueryHandler)
        }
    }

    //MARK: Button Actions

    @objc
    private func close(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

//MARK: UITableViewDataSource

extension HistoryTableViewController: UITableViewDataSource {

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activities.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! HistoryTableViewCell

        let activity = activities[indexPath.row]
        let motionTypes = join(", ", activity.motionTypes)

        cell.textLabel?.text = motionTypes
        cell.detailTextLabel?.text = "\(activity.dateString), \(activity.confidenceString)"

        return cell
    }
}
