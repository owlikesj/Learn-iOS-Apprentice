//
//  CheckListItem.swift
//  checklists
//
//  Created by wang shijie on 2018/9/25.
//  Copyright © 2018 wangshijie. All rights reserved.
//

import Foundation

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    init(text: String = "", checked: Bool = false) {
        self.text = text
        self.checked = checked
    }
    func toggleCheckd() {
        checked = !checked
    }
}
