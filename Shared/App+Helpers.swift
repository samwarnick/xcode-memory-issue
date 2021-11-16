//
//  App+Helpers.swift
//  Savings Tracker
//
//  Created by Sam Warnick on 11/14/21.
//

import Foundation

#if DEBUG
let groupIdentifier = "group.com.samwarnick.Savings_Tracker.dev"
#else
let groupIdentifier = "group.com.samwarnick.Savings_Tracker"
#endif

let bundleIdentifier = Bundle.main.bundleIdentifier!
let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
let appBuild = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
let fullVersion = "\(appVersion) \(appBuild)"
