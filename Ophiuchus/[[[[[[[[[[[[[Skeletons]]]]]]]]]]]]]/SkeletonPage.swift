//
//  SkeletonPage.swift
//  Ophiuchus
//
//  Created by Nick on 7/3/25.
//

import Foundation

public class SkeletonPage {
    
    public let rows: [SkeletonRow]
    init(rows: [SkeletonRow]) {
        self.rows = rows
    }
    
    init(row: SkeletonRow) {
        self.rows = [row]
    }
    
    func prepare(menuWidthWithSafeArea: Int,
                 safeAreaLeft: Int,
                 safeAreaRight: Int) {
        for row in rows {
            row.prepare()
        }
    }
    
}
