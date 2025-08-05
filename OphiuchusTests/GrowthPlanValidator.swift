//
//  GrowthPlanValidator.swift
//  OphiuchusTests
//
//  Created by Nick on 8/4/25.
//

import Foundation
import Testing
@testable import Ophiuchus

struct GrowthPlanValidator {
    
    private static func union<ElementType: ExploderConforming>(list1: [ElementType], list2: [ElementType]) -> [ElementType] {
        var result = [ElementType]()
        var set = Set<Int>()
        for item in list1 {
            set.insert(item.id)
        }
        for item in list2 {
            if set.contains(item.id) {
                result.append(item)
            }
        }
        return result
    }
    
    private static func getParents(chunks: [SkeletonChunk]) -> [SkeletonNode] {
        var set = Set<Int>()
        var result = [SkeletonNode]()
        for chunk in chunks {
            if !set.contains(chunk.node.id) {
                result.append(chunk.node)
                set.insert(chunk.node.id)
            }
        }
        return result
    }
    
    private static func getParents(flexers: [Flexer]) -> [SkeletonChunk] {
        var set = Set<Int>()
        var result = [SkeletonChunk]()
        for flexer in flexers {
            if !set.contains(flexer.chunk.id) {
                result.append(flexer.chunk)
                set.insert(flexer.chunk.id)
            }
        }
        return result
    }
    
    private static func getParents(pieces: [SkeletonPiece]) -> [SkeletonChunk] {
        var set = Set<Int>()
        var result = [SkeletonChunk]()
        for piece in pieces {
            if !set.contains(piece.chunk.id) {
                result.append(piece.chunk)
                set.insert(piece.chunk.id)
            }
        }
        return result
    }
    
    private static func getSections(growthPlans: [GrowthPlan]) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        for growthPlan in growthPlans {
            result.append(growthPlan.section)
        }
        return result
    }
    
    private static func duplicate(growthPlans: [GrowthPlan]) -> Bool {
        var set = Set<Int>()
        
        for growthPlan in growthPlans {
            if set.contains(growthPlan.section.id) {
                print("Fatal! Duplicate Growth Plan!")
                return true
            }
        }
        return false
    }
    
    private static func duplicate(rows: [SkeletonRow]) -> Bool {
        var set = Set<Int>()
        for row in rows {
            if set.contains(row.id) {
                print("Fatal! Duplicate Row!")
                return true
            }
            set.insert(row.id)
        }
        return false
    }
    
    private static func duplicate<ElementType: ExploderConforming>(list: [ElementType], name: String) -> Bool {
        var set = Set<Int>()
        for item in list {
            if set.contains(item.id) {
                print("Fatal! Duplicate Growth \(name)!")
                return true
            }
            set.insert(item.id)
        }
        return false
    }
    
    static func getGrowthPlans(pRow: SkeletonRow,
                               pRowGrowthPlansList: [RowGrowthPlans]) -> [GrowthPlan] {
        var result = [GrowthPlan]()
        
        for rowGrowthPlans in pRowGrowthPlansList {
            if rowGrowthPlans.row === pRow {
                for growthPlan in rowGrowthPlans.growthPlans {
                    result.append(growthPlan)
                }
            }
        }
        
        return result
    }
    
    static func printDump(pChunks: [SkeletonChunk]) {
        print("===========================================")
        for chunk in pChunks {
            print("List-Chunk{\(chunk.id)} in question, \(chunk.pieces.count) pieces, \(chunk.flexers.count) flexers.")
        }
        print("===========================================")
    }
    
    static func printDump(pNodes: [SkeletonNode]) {
        print("===========================================")
        for node in pNodes {
            print("List-Node{\(node.id)} in question, \(node.chunks.count) chunks, \(node.countPieces()) pieces, \(node.countFlexers()) flexers.")
        }
        print("===========================================")
    }
    
    static func printDump(pSections: [SkeletonSection]) {
        print("===========================================")
        for section in pSections {
            print("List-Section{\(section.id)} in question, \(section.skeletonNodes.count) nodes, \(section.countChunks()) chunks, \(section.countPieces()) pieces, \(section.countFlexers()) flexers.")
        }
        print("===========================================")
    }
    
    static func printDump(pRows: [SkeletonRow]) {
        print("===========================================")
        for row in pRows {
            print("List-Row{\(row.id)} in question, \(row.sections.count) sections, \(row.countNodes()) nodes, \(row.countChunks()) chunks, \(row.countPieces()) pieces, \(row.countFlexers()) flexers.")
        }
        print("===========================================")
    }
    
    static func printDump(pRow: SkeletonRow) {
        print("===========================================")
        print("Row{\(pRow.id)} in question, \(pRow.sections.count) sections, \(pRow.countNodes()) nodes, \(pRow.countChunks()) chunks, \(pRow.countPieces()) pieces, \(pRow.countFlexers()) flexers.")
        for section in pRow.sections {
            print("\tSection{\(section.id)} \(section.skeletonNodes.count) nodes (\(section.childrenSize) / \(section.currentSize))")
            for node in section.skeletonNodes {
                print("\t\tNode{\(node.id)} \(node.chunks.count) chunks (\(node.childrenSize) / \(node.currentSize))")
                for chunk in node.chunks {
                    print("\t\t\tChunk{\(chunk.id)} with \(chunk.pieces.count) pieces and \(chunk.flexers.count) flexers. (\(chunk.childrenSize) / \(chunk.currentSize))")
                }
            }
        }
        print("===========================================")
        
    }
    
    static func printDump(pGrowthPlan: GrowthPlan) {
        print("===========================================")
        print("GrowthPlan \(pGrowthPlan.amount) amount")
        let section = pGrowthPlan.section
        print("GrowthPlan-Section{\(section.id)} in question, \(section.skeletonNodes.count) nodes, \(section.countChunks()) chunks, \(section.countPieces()) pieces, \(section.countFlexers()) flexers.")
        print("===========================================")
        
    }
    
    static func printDump(pRowGrowthPlansList: [RowGrowthPlans]) {
        
        print("===========================================")
        print("Row growth plan list with \(pRowGrowthPlansList.count) row growth plans.")
        for rowGrowthPlans in pRowGrowthPlansList {
            print("\tRowGrowthPlan for row \(rowGrowthPlans.row.id), having \(rowGrowthPlans.growthPlans.count) grow plans.")
            for growPlan in rowGrowthPlans.growthPlans {
                let section = growPlan.section
                print("\t\tGrowPlan, amount \(growPlan.amount), section \(section.id), \(section.skeletonNodes.count) nodes (\(section.childrenSize) / \(section.currentSize))")
            }
        }
        print("===========================================")
    }
    
    static func checkRowsAgainstPlans(pRows: [SkeletonRow],
                                      pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        
        var sectionRowMap = [Int: SkeletonRow]()
        for rowGrowthPlans in pRowGrowthPlansList {
            for growthPlan in rowGrowthPlans.growthPlans {
                if sectionRowMap[growthPlan.section.id] != nil {
                    print("Fatal! There is the same section twice in growth plans.")
                    printDump(pRow: rowGrowthPlans.row)
                    printDump(pRows: pRows)
                    printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                    return false
                }
                sectionRowMap[growthPlan.section.id] = rowGrowthPlans.row
            }
        }
        
        var rowMap = [Int: SkeletonRow]()
        for rowGrowthPlans in pRowGrowthPlansList {
            if rowMap[rowGrowthPlans.row.id] != nil {
                print("Fatal! There are 2 growth plans for 1 row!")
                printDump(pRow: rowGrowthPlans.row)
                printDump(pRows: pRows)
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            rowMap[rowGrowthPlans.row.id] = rowGrowthPlans.row
        }
        return true
    }
    
    // Basically, each growth plan should have an amount of 1 for this case...
    static func checkSections(pRows: [SkeletonRow],
                              pSections: [SkeletonSection],
                              pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        if !checkRowsAgainstPlans(pRows: pRows,
                                  pRowGrowthPlansList: pRowGrowthPlansList) {
            printDump(pRows: pRows)
            printDump(pRowGrowthPlansList: pRowGrowthPlansList)
            return false
        }
        if duplicate(rows: pRows) {
            printDump(pRows: pRows)
            return false
        }
        if duplicate(list: pSections, name: "Section") {
            printDump(pSections: pSections)
            return false
        }
        
        for pRow in pRows {
            let growthPlans = getGrowthPlans(pRow: pRow, pRowGrowthPlansList: pRowGrowthPlansList)
            if duplicate(growthPlans: growthPlans) {
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            
            let growthPlanSections = getSections(growthPlans: growthPlans)
            let sectionsUnion = union(list1: growthPlanSections, list2: pRow.sections)
            if sectionsUnion.count != growthPlanSections.count {
                print("Fatal! The sections did not jibe, 2nd auth factor..")
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                printDump(pRow: pRow)
                return false
            }
            
            for growthPlan in growthPlans {
                if growthPlan.amount != 1 {
                    print("Fatal! For sections, all growth plans should be 1...)")
                    printDump(pGrowthPlan: growthPlan)
                    return false
                }
            }
            
        }
        
        return true
    }
    
    
    static func checkNodes(pRows: [SkeletonRow],
                           pNodes: [SkeletonNode],
                           pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        if !checkRowsAgainstPlans(pRows: pRows,
                                  pRowGrowthPlansList: pRowGrowthPlansList) {
            printDump(pRows: pRows)
            printDump(pRowGrowthPlansList: pRowGrowthPlansList)
            return false
        }
        if duplicate(rows: pRows) {
            printDump(pRows: pRows)
            return false
        }
        if duplicate(list: pNodes, name: "Node") {
            printDump(pNodes: pNodes)
            return false
        }
        
        for pRow in pRows {
            let growthPlans = getGrowthPlans(pRow: pRow, pRowGrowthPlansList: pRowGrowthPlansList)
            if duplicate(growthPlans: growthPlans) {
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            
            let growthPlanSections = getSections(growthPlans: growthPlans)
            let sectionsUnion = union(list1: growthPlanSections, list2: pRow.sections)
            if sectionsUnion.count != growthPlanSections.count {
                print("Fatal! The sections did not jibe, 2nd auth factor..")
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                printDump(pRow: pRow)
                return false
            }
            
            for growthPlan in growthPlans {
                let mergedNodes = union(list1: pNodes, list2: growthPlan.section.skeletonNodes)
                
                var expectedGrowth = mergedNodes.count
                
                expectedGrowth -= growthPlan.section.getGap()
                if expectedGrowth < 0 { expectedGrowth = 0 }
                guard expectedGrowth == growthPlan.amount else {
                    print("Fatal! Expected growth to be \(expectedGrowth), we got \(growthPlan.amount)")
                    printDump(pRow: pRow)
                    printDump(pNodes: pNodes)
                    printDump(pGrowthPlan: growthPlan)
                    return false
                }
            }
        }
        
        return true
    }
    
    static func checkChunks(pRows: [SkeletonRow],
                            pChunks: [SkeletonChunk],
                            pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        if !checkRowsAgainstPlans(pRows: pRows,
                                  pRowGrowthPlansList: pRowGrowthPlansList) {
            printDump(pRows: pRows)
            printDump(pRowGrowthPlansList: pRowGrowthPlansList)
            return false
        }
        if duplicate(rows: pRows) {
            printDump(pRows: pRows)
            return false
        }
        if duplicate(list: pChunks, name: "Chunk") {
            printDump(pChunks: pChunks)
            return false
        }
        
        for pRow in pRows {
            let growthPlans = getGrowthPlans(pRow: pRow, pRowGrowthPlansList: pRowGrowthPlansList)
            if duplicate(growthPlans: growthPlans) {
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            
            let growthPlanSections = getSections(growthPlans: growthPlans)
            let sectionsUnion = union(list1: growthPlanSections, list2: pRow.sections)
            if sectionsUnion.count != growthPlanSections.count {
                print("Fatal! The sections did not jibe, 2nd auth factor..")
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                printDump(pRow: pRow)
                return false
            }
            
            for growthPlan in growthPlans {
                var expectedGrowth = 0
                for node in growthPlan.section.skeletonNodes {
                    let mergedChunks = union(list1: pChunks, list2: node.chunks)
                    if mergedChunks.count > 0 {
                        var expectedNodeGrowth = mergedChunks.count
                        expectedNodeGrowth -= node.getGap()
                        if expectedNodeGrowth < 0 { expectedNodeGrowth = 0 }
                        expectedGrowth += expectedNodeGrowth
                    }
                }
                
                expectedGrowth -= growthPlan.section.getGap()
                if expectedGrowth < 0 { expectedGrowth = 0 }
                
                guard expectedGrowth == growthPlan.amount else {
                    print("Fatal! Expected growth to be \(expectedGrowth), we got \(growthPlan.amount)")
                    printDump(pRow: pRow)
                    printDump(pChunks: pChunks)
                    printDump(pGrowthPlan: growthPlan)
                    return false
                }
            }
        }
        return true
    }
    
    
    static func checkFlexers(pRows: [SkeletonRow],
                            pFlexers: [Flexer],
                            pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        if !checkRowsAgainstPlans(pRows: pRows,
                                  pRowGrowthPlansList: pRowGrowthPlansList) {
            printDump(pRows: pRows)
            printDump(pRowGrowthPlansList: pRowGrowthPlansList)
            return false
        }
        if duplicate(rows: pRows) {
            printDump(pRows: pRows)
            return false
        }
        if duplicate(list: pFlexers, name: "Flexer") {
            return false
        }
        
        for pRow in pRows {
            let growthPlans = getGrowthPlans(pRow: pRow, pRowGrowthPlansList: pRowGrowthPlansList)
            if duplicate(growthPlans: growthPlans) {
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            
            let growthPlanSections = getSections(growthPlans: growthPlans)
            let sectionsUnion = union(list1: growthPlanSections, list2: pRow.sections)
            if sectionsUnion.count != growthPlanSections.count {
                print("Fatal! The sections did not jibe, 2nd auth factor..")
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                printDump(pRow: pRow)
                return false
            }
            
            for growthPlan in growthPlans {
                
                
                var expectedGrowth = 0
                
                
                for node in growthPlan.section.skeletonNodes {
                    
                    var expectedNodeGrowth = 0
                    for chunk in node.chunks {
                        
                        var expectedChunkGrowth = 0
                        
                        let mergedFlexers = union(list1: pFlexers, list2: chunk.flexers)
                        if mergedFlexers.count > 0 {
                            // This is just the number of flexers
                            // (the ones in our rule AND this section>node>chunk)
                            let expectedFlexerGrowth = mergedFlexers.count
                            expectedChunkGrowth += expectedFlexerGrowth
                        }
                        
                        // We have summed all the contents of the chunk
                        // Now we can subtract out the chunk's gap.
                        expectedChunkGrowth -= chunk.getGap()
                        if expectedChunkGrowth < 0 { expectedChunkGrowth = 0 }
                        
                        // Pass it up to the node... This is
                        // a little harder to grip... Just the
                        // output of the chunk as one of N input
                        // to the node...
                        expectedNodeGrowth += expectedChunkGrowth
                        
                    }
                    
                    // We have summed all the contents of the node
                    // Now we can subtract out the node's gap.
                    expectedNodeGrowth -= node.getGap()
                    if expectedNodeGrowth < 0 { expectedNodeGrowth = 0 }
                    
                    // Pass it up to the section
                    expectedGrowth += expectedNodeGrowth
                }
                
                // We have summed all the contents of the section
                // Now we can subtract out the section's gap.
                expectedGrowth -= growthPlan.section.getGap()
                if expectedGrowth < 0 { expectedGrowth = 0 }
                
                // Tada! This is how much the section must expand.
                
                print("expectedGrowth was \(expectedGrowth), got \(growthPlan.amount)")
                
                guard expectedGrowth == growthPlan.amount else {
                    print("Fatal! Expected growth to be \(expectedGrowth), we got \(growthPlan.amount)")
                    printDump(pRow: pRow)
                    printDump(pGrowthPlan: growthPlan)
                    return false
                }
            }
        }
        return true
    }

    
    
    
    
    static func checkPieces(pRows: [SkeletonRow],
                            pPieces: [SkeletonPiece],
                            pRowGrowthPlansList: [RowGrowthPlans]) -> Bool {
        if !checkRowsAgainstPlans(pRows: pRows,
                                  pRowGrowthPlansList: pRowGrowthPlansList) {
            printDump(pRows: pRows)
            printDump(pRowGrowthPlansList: pRowGrowthPlansList)
            return false
        }
        if duplicate(rows: pRows) {
            printDump(pRows: pRows)
            return false
        }
        if duplicate(list: pPieces, name: "Piece") {
            return false
        }
        
        for pRow in pRows {
            let growthPlans = getGrowthPlans(pRow: pRow, pRowGrowthPlansList: pRowGrowthPlansList)
            if duplicate(growthPlans: growthPlans) {
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                return false
            }
            
            let growthPlanSections = getSections(growthPlans: growthPlans)
            let sectionsUnion = union(list1: growthPlanSections, list2: pRow.sections)
            if sectionsUnion.count != growthPlanSections.count {
                print("Fatal! The sections did not jibe, 2nd auth factor..")
                printDump(pRowGrowthPlansList: pRowGrowthPlansList)
                printDump(pRow: pRow)
                return false
            }
            
            for growthPlan in growthPlans {
                
                
                var expectedGrowth = 0
                
                
                for node in growthPlan.section.skeletonNodes {
                    
                    var expectedNodeGrowth = 0
                    for chunk in node.chunks {
                        
                        var expectedChunkGrowth = 0
                        
                        let mergedPieces = union(list1: pPieces, list2: chunk.pieces)
                        if mergedPieces.count > 0 {
                            // This is just the number of pieces
                            // (the ones in our rule AND this section>node>chunk)
                            let expectedPieceGrowth = mergedPieces.count
                            expectedChunkGrowth += expectedPieceGrowth
                        }
                        
                        // We have summed all the contents of the chunk
                        // Now we can subtract out the chunk's gap.
                        expectedChunkGrowth -= chunk.getGap()
                        if expectedChunkGrowth < 0 { expectedChunkGrowth = 0 }
                        
                        // Pass it up to the node... This is
                        // a little harder to grip... Just the
                        // output of the chunk as one of N input
                        // to the node...
                        expectedNodeGrowth += expectedChunkGrowth
                        
                    }
                    
                    // We have summed all the contents of the node
                    // Now we can subtract out the node's gap.
                    expectedNodeGrowth -= node.getGap()
                    if expectedNodeGrowth < 0 { expectedNodeGrowth = 0 }
                    
                    // Pass it up to the section
                    expectedGrowth += expectedNodeGrowth
                }
                
                // We have summed all the contents of the section
                // Now we can subtract out the section's gap.
                expectedGrowth -= growthPlan.section.getGap()
                if expectedGrowth < 0 { expectedGrowth = 0 }
                
                // Tada! This is how much the section must expand.
                
                print("expectedGrowth was \(expectedGrowth), got \(growthPlan.amount)")
                
                guard expectedGrowth == growthPlan.amount else {
                    print("Fatal! Expected growth to be \(expectedGrowth), we got \(growthPlan.amount)")
                    printDump(pRow: pRow)
                    printDump(pGrowthPlan: growthPlan)
                    return false
                }
            }
        }
        return true
    }
    
}
