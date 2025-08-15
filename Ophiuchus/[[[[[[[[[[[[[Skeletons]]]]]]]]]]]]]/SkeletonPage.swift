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
        
        /*
        for row in rows {
            for section in row.sections {
                section.row = row
                for node in section.skeletonNodes {
                    node.row = row
                    node.section = section
                    for chunk in node.chunks {
                        chunk.row = row
                        chunk.section = section
                        chunk.node = node
                        for piece in chunk.pieces {
                            piece.row = row
                            piece.section = section
                            piece.node = node
                            piece.chunk = chunk
                        }
                        for flexer in chunk.flexers {
                            flexer.row = row
                            flexer.section = section
                            flexer.node = node
                            flexer.chunk = chunk
                        }
                    }
                }
            }
        }
        
        for row in rows {
            for section in row.sections {
                section.row = row
                for node in section.skeletonNodes {
                    node.row = row
                    node.section = section
                }
            }
        }
        */
        
        for row in rows {
            row.prepare()
        }
    }
    
}
