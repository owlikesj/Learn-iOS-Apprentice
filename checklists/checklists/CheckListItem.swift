//
//  CheckListItem.swift
//  checklists
//
//  Created by wang shijie on 2018/9/25.
//  Copyright © 2018 wangshijie. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
        self.itemID = DataModel.nextChecklistItemID()
    }
    deinit {
        removeNotification()
    }
    func toggleCheckd() {
        checked = !checked
    }
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(
            withIdentifiers: ["\(itemID)"])
    }
    func scheduleNotification() {
        removeNotification()
        if shouldRemind && dueDate > Date() {
            // 1
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()
            // 2
            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents(
                [.month, .day, .hour, .minute],
                from: dueDate)
            // 3
            let trigger = UNCalendarNotificationTrigger(
                dateMatching: components,
                repeats: false)
            // 4
            let request = UNNotificationRequest(
                identifier: "\(itemID)", content: content,
                trigger: trigger)
            // 5
            let center = UNUserNotificationCenter.current()
            center.add(request)
            print("Scheduled: \(request) for itemID: \(itemID)")
        }
    }
}
