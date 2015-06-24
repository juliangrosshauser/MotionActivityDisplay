//
//  CMMotionActivity.swift
//  MotionActivityDisplay
//
//  Created by Julian Grosshauser on 24/06/15.
//  Copyright (c) 2015 Julian Grosshauser. All rights reserved.
//

import CoreMotion

extension CMMotionActivity {

    //MARK: Properties

    var motionTypes: [String] {
        var motionTypes = [String]()

        if self.stationary {
            motionTypes.append("stationary")
        }

        if self.walking {
            motionTypes.append("walking")
        }

        if self.running {
            motionTypes.append("running")
        }

        if self.automotive {
            motionTypes.append("automotive")
        }

        if self.cycling {
            motionTypes.append("cycling")
        }

        if self.unknown {
            motionTypes.append("unknown")
        }

        if motionTypes.isEmpty {
            motionTypes.append("unidentified motion type")
        }

        return motionTypes
    }

    var dateString: String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .ShortStyle

        return "Start date: \(dateFormatter.stringFromDate(self.startDate))"
    }

    var confidenceString: String {
        var confidenceString = "Confidence: "

        switch self.confidence {
            case .Low:
                confidenceString += "Low"

            case .Medium:
                confidenceString += "Medium"

            case .High:
                confidenceString += "High"
        }

        return confidenceString
    }
}
