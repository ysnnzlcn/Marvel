//
//  BaseTableViewDataSource.swift
//  Marvel
//
//  Created by Yasin Nazlican on 21.08.2021.
//

import Foundation

public class BaseTableViewDataSource<T>: NSObject {
    
    public struct Item {
        
        public let cell: T
        
        public init(cell: T) {
            self.cell = cell
        }
    }

    public struct Section {
        
        public var items: [Item]
        public let title: String?
        public let shouldShowHeader: Bool
        
        public init(items: [Item] = [], title: String? = nil, shouldShowHeader: Bool = true) {
            self.items = items
            self.title = title
            self.shouldShowHeader = shouldShowHeader
        }
    }
}
