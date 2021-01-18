//
//  Order.swift
//  OrderApp
//
//  Created by Yuki Tsukada on 2021/01/17.
//

import Foundation

struct Order: Codable {
    var menuItems: [MenuItem]
    
    init(menuItems: [MenuItem] = []) {
        self.menuItems = menuItems
    }
}
