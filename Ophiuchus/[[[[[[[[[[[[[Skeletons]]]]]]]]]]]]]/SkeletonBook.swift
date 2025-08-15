//
//  SkeletonBook.swift
//  Ophiuchus
//
//  Created by Nick on 7/5/25.
//

import Foundation

public class SkeletonBook {
    public let pages: [SkeletonPage]
    public let nodeRules: [SkeletonLinkageRule_Nodes]
    public let flexerRules: [SkeletonLinkageRule_Flexers]
    public let pieceRules: [SkeletonLinkageRule_Pieces]
    init(pages: [SkeletonPage],
         nodeRules: [SkeletonLinkageRule_Nodes],
         flexerRules: [SkeletonLinkageRule_Flexers],
         pieceRules: [SkeletonLinkageRule_Pieces]) {
        self.pages = pages
        self.nodeRules = nodeRules
        self.flexerRules = flexerRules
        self.pieceRules = pieceRules
    }
    
    convenience init(rows: [SkeletonRow],
                     nodeRules: [SkeletonLinkageRule_Nodes],
                     flexerRules: [SkeletonLinkageRule_Flexers],
                     pieceRules: [SkeletonLinkageRule_Pieces]) {
        let page = SkeletonPage(rows: rows)
        self.init(pages: [page],
                  nodeRules: nodeRules,
                  flexerRules: flexerRules,
                  pieceRules: pieceRules)
    }
    
    convenience init(rows: [SkeletonRow]) {
        let page = SkeletonPage(rows: rows)
        self.init(pages: [page],
                  nodeRules: [],
                  flexerRules: [],
                  pieceRules: [])
    }
    
    
    
    public init() {
        self.pages = []
        self.nodeRules = []
        self.flexerRules = []
        self.pieceRules = []
    }
    
    func prepare(menuWidthWithSafeArea: Int,
                 safeAreaLeft: Int,
                 safeAreaRight: Int) {
        for page in pages {
            page.prepare(menuWidthWithSafeArea: menuWidthWithSafeArea,
                         safeAreaLeft: safeAreaLeft,
                         safeAreaRight: safeAreaRight)
        }
    }

    func codegen() {
        
        print("CODE GEN CODE GEN CODE GEN CODE GEN CODE GEN")
        
        var name_list = [
            // English a-z
            "a","b","c","d","e","f","g","h","i","j","k","l","m",
            "n","o","p","q","r","s","t","u","v","w","x","y","z",
            // Greek α-ω
            "α","β","γ","δ","ε","ζ","η","θ","ι","κ","λ","μ",
            "ν","ξ","ο","π","ρ","σ","τ","υ","φ","χ","ψ","ω"
        ];
        
        var _pieces = [SkeletonPiece]()
        var _flexers = [Flexer]()
        var _nodes = [WiseLayoutNode]()
        var _sections = [SkeletonSection]()
        var _rows = [SkeletonRow]()
        
        var row_names = [Int: String]()
        var section_names = [Int: String]()
        var node_names = [Int: String]()
        var piece_names = [Int: String]()
        var flexer_names = [Int: String]()
        
        var row_names_list = [String]()
        var row_id_list = [Int]()
        var row_map = [Int: SkeletonRow]()
        
        var section_names_list = [String]()
        var section_id_list = [Int]()
        var section_map = [Int: SkeletonSection]()
        
        var node_names_list = [String]()
        var node_id_list = [Int]()
        var node_map = [Int: WiseLayoutNode]()
        
        var piece_names_list = [String]()
        var piece_id_list = [Int]()
        var piece_map = [Int: SkeletonPiece]()
        
        var flexer_names_list = [String]()
        var flexer_id_list = [Int]()
        var flexer_map = [Int: Flexer]()
        
        
        for pageIndex in 0..<pages.count {
            let page = pages[pageIndex]
            
            var rowNumber = 0
            var nodeNumber = 0
            var sectionNumber = 0
            var pieceNumber = 0
            var flexerNumber = 0
            
            for row in page.rows {
                row_names[row.id] = "row_" + name_list[rowNumber]
                row_names_list.append("row_" + name_list[rowNumber])
                row_id_list.append(row.id)
                row_map[row.id] = row
                rowNumber += 1
                
                for section in row.sections {
                    section_names[section.id] = "sec_" + name_list[sectionNumber]
                    section_names_list.append("sec_" + name_list[sectionNumber])
                    section_id_list.append(section.id)
                    section_map[section.id] = section
                    sectionNumber += 1
                    
                    for node in section.nodes {
                        
                        node_names[node.id] = "nod_" + name_list[nodeNumber]
                        node_names_list.append("nod_" + name_list[nodeNumber])
                        node_id_list.append(node.id)
                        node_map[node.id] = node
                        nodeNumber += 1
                        
                        for piece in node.pieces {
                            piece_names[piece.id] = "pce_" + name_list[pieceNumber]
                            piece_names_list.append("pce_" + name_list[pieceNumber])
                            piece_id_list.append(piece.id)
                            piece_map[piece.id] = piece
                            pieceNumber += 1
                        }
                        
                        for flexer in node.flexers {
                            flexer_names[flexerNumber] = "flx_" + name_list[flexerNumber]
                            flexer_names_list.append("flx_" + name_list[flexerNumber])
                            flexer_id_list.append(flexer.id)
                            flexer_map[flexer.id] = flexer
                            flexerNumber += 1
                        }
                    }
                }
            }
        }
        
        print("=====")
        if piece_names_list.count > 0 {
            for (index, piece_name) in piece_names_list.enumerated() {
                let piece = piece_map[piece_id_list[index]]!
                print("let \(piece_name) = GeneratePieces.generate(size: \(piece.originalSize))")
            }
            print("\n")
        }
        
        if flexer_names_list.count > 0 {
            for (index, flexer_name) in flexer_names_list.enumerated() {
                let flexer = flexer_map[flexer_id_list[index]]!
                
                let desiredSizeRequired = flexer.desiredSizeRequired
                let desiredSizeHigh = flexer.desiredSizeHigh
                let desiredSizeMedium = flexer.desiredSizeMedium
                let desiredSizeLow = flexer.desiredSizeLow
                let desiredSizeFinally = flexer.desiredSizeFinally
                print("let \(flexer_name) = GenerateFlexers.generate(\(desiredSizeRequired), \(desiredSizeHigh), \(desiredSizeMedium), \(desiredSizeLow), \(desiredSizeFinally))")
            }
            print("\n")
        }
        
        
        
        if node_names_list.count > 0 {
            for (index, node_name) in node_names_list.enumerated() {
                let node = node_map[node_id_list[index]]!
                var piece_array_string = "[]"
                var flexer_array_string = "[]"
                print("let \(node_name) = GenerateNodes.generate(pieces: \(piece_array_string), flexers: \(flexer_array_string))")
                print("\(node_name).currentSize = \(node.currentSize)")
                print("\(node_name).childrenSize = \(node.childrenSize)")
                print("\(node_name).requestedGrowthFromChildren = \(node.requestedGrowthFromChildren)")
                print("\n")
            }
            print("\n")
            
        }
        
        if section_names_list.count > 0 {
            for (index, section_name) in section_names_list.enumerated() {
                let section = section_map[section_id_list[index]]!
                var nodes_array_string = "["
                
                var list_of_node_names = [String]()
                for node in section.nodes {
                    let node_name = node_names[node.id]!
                    list_of_node_names.append(node_name)
                }
                
                nodes_array_string += list_of_node_names.joined(separator: ", ")
                nodes_array_string += "]"
                
                print("let \(section_name) = GenerateSections.generate(nodes: \(nodes_array_string))")
                print("\(section_name).currentSize = \(section.currentSize)")
            }
            print("\n")
        }
        
        if row_names_list.count > 0 {
            for (index, row_name) in row_names_list.enumerated() {
                let row = row_map[row_id_list[index]]!
                var sections_array_string = "["
                
                var list_of_section_names = [String]()
                for section in row.sections {
                    let section_name = section_names[section.id]!
                    list_of_section_names.append(section_name)
                }
                
                sections_array_string += list_of_section_names.joined(separator: ", ")
                sections_array_string += "]"
                
                print("let \(row_name) = GenerateRows.generate(sections:  \(sections_array_string))")
                print("\(row_name).growthBudget = \(row.growthBudget)")
                
            }
            print("\n")
        }
        
        
        var node_rule_list = [String]()
        
        for nodeRule in nodeRules {
            
            var nodes_array_string = "["
            
            var list_of_node_names = [String]()
            for node in nodeRule.nodes {
                let node_name = node_names[node.id]!
                list_of_node_names.append(node_name)
            }
            
            nodes_array_string += list_of_node_names.joined(separator: ",\n")
            nodes_array_string += "]"
            
            let prio = nodeRule.layoutPriority.toString()
            
            node_rule_list.append("SkeletonLinkageRule_Nodes(nodes: \(nodes_array_string), layoutPriority: \(prio))")
            
        }
        
        var node_rule_array_string = "["
        node_rule_array_string += node_rule_list.joined(separator: ",\n")
        node_rule_array_string += "]"
        
        
        print("let rows = [\(row_names_list.joined(separator: ", "))]")
        print("let sections = [\(section_names_list.joined(separator: ", "))]")
        print("let nodes = [\(node_names_list.joined(separator: ", "))]")
        
        print("let nodeRules = \(node_rule_array_string)")
        
        
        
        //public let nodeRules: [SkeletonLinkageRule_Nodes]
        //public let flexerRules: [SkeletonLinkageRule_Flexers]
        //public let pieceRules: [SkeletonLinkageRule_Pieces]
        
    }
    
    
    func codegen_grow_node_with_piece_group() {
        
        print("CODE GEN CODE GEN CODE GEN CODE GEN CODE GEN")
        
        var name_list = [
            // English a-z
            "a","b","c","d","e","f","g","h","i","j","k","l","m",
            "n","o","p","q","r","s","t","u","v","w","x","y","z",
            // Greek α-ω
            "α","β","γ","δ","ε","ζ","η","θ","ι","κ","λ","μ",
            "ν","ξ","ο","π","ρ","σ","τ","υ","φ","χ","ψ","ω"
        ];
        
        
        var _nodes = [WiseLayoutNode]()
        var _sections = [SkeletonSection]()
        var _rows = [SkeletonRow]()
        
        var row_names = [Int: String]()
        var section_names = [Int: String]()
        var node_names = [Int: String]()
        
        var node_gen_names = [Int: String]()
        
        
        
        var row_names_list = [String]()
        var row_id_list = [Int]()
        var row_map = [Int: SkeletonRow]()
        
        var section_names_list = [String]()
        var section_id_list = [Int]()
        var section_map = [Int: SkeletonSection]()
        
        var node_names_list = [String]()
        var node_gen_names_list = [String]()
        
        var node_id_list = [Int]()
        var node_map = [Int: WiseLayoutNode]()
        
        var piece_names_list = [String]()
        var piece_id_list = [Int]()
        var piece_map = [Int: SkeletonPiece]()
        
        var flexer_names_list = [String]()
        var flexer_id_list = [Int]()
        var flexer_map = [Int: Flexer]()
        
        
        for pageIndex in 0..<pages.count {
            let page = pages[pageIndex]
            
            var rowNumber = 0
            var nodeNumber = 0
            var sectionNumber = 0
            var pieceNumber = 0
            var flexerNumber = 0
            
            for row in page.rows {
                row_names[row.id] = "row_" + name_list[rowNumber]
                row_names_list.append("row_" + name_list[rowNumber])
                row_id_list.append(row.id)
                row_map[row.id] = row
                rowNumber += 1
                
                for section in row.sections {
                    section_names[section.id] = "sec_" + name_list[sectionNumber]
                    section_names_list.append("sec_" + name_list[sectionNumber])
                    section_id_list.append(section.id)
                    section_map[section.id] = section
                    sectionNumber += 1
                    
                    for node in section.nodes {
                        
                        node_names[node.id] = "nod_" + name_list[nodeNumber]
                        node_names_list.append("nod_" + name_list[nodeNumber])
                        
                        node_gen_names[node.id] = "nnod_" + name_list[nodeNumber]
                        node_gen_names_list.append("nnod_" + name_list[nodeNumber])
                        
                        
                        node_id_list.append(node.id)
                        node_map[node.id] = node
                        nodeNumber += 1
                        
                        
                    }
                }
            }
        }
        
        print("=====")
        
        
        if node_names_list.count > 0 {
            for (index, node_name) in node_names_list.enumerated() {
                let node_gen_name = node_gen_names_list[index]
                let node = node_map[node_id_list[index]]!
                let currentSize = node.currentSize
                let childrenSize = node.childrenSize
                let requestedGrowthFromChildren = node.requestedGrowthFromChildren
                print("let \(node_gen_name) = GenerateNodes.generate(currentSize: \(currentSize), childrenSize: \(childrenSize), piecesToGrow: \(requestedGrowthFromChildren), amount: 1)")
                print("let \(node_name) = \(node_gen_name).0")
            }
            print("\n")
            
        }
        
        if section_names_list.count > 0 {
            for (index, section_name) in section_names_list.enumerated() {
                let section = section_map[section_id_list[index]]!
                var nodes_array_string = "["
                
                var list_of_node_names = [String]()
                for node in section.nodes {
                    let node_name = node_names[node.id]!
                    list_of_node_names.append(node_name)
                }
                
                nodes_array_string += list_of_node_names.joined(separator: ", ")
                nodes_array_string += "]"
                
                print("let \(section_name) = GenerateSections.generate(nodes: \(nodes_array_string))")
                print("\(section_name).currentSize = \(section.currentSize)")
            }
            print("\n")
        }
        
        if row_names_list.count > 0 {
            for (index, row_name) in row_names_list.enumerated() {
                let row = row_map[row_id_list[index]]!
                var sections_array_string = "["
                
                var list_of_section_names = [String]()
                for section in row.sections {
                    let section_name = section_names[section.id]!
                    list_of_section_names.append(section_name)
                }
                
                sections_array_string += list_of_section_names.joined(separator: ", ")
                sections_array_string += "]"
                
                print("let \(row_name) = GenerateRows.generate(sections:  \(sections_array_string))")
                print("\(row_name).growthBudget = \(row.growthBudget)")
                
            }
            print("\n")
        }
        
        print("var pieceRules = [SkeletonLinkageRule_Pieces]()")
        
        for node_gen_name in node_gen_names_list {
            print("pieceRules.append(\(node_gen_name).1)")
        }
        
        var node_rule_list = [String]()
        for nodeRule in nodeRules {
            
            var nodes_array_string = "["
            
            var list_of_node_names = [String]()
            for node in nodeRule.nodes {
                let node_name = node_names[node.id]!
                list_of_node_names.append(node_name)
            }
            
            nodes_array_string += list_of_node_names.joined(separator: ",\n")
            nodes_array_string += "]"
            
            let prio = nodeRule.layoutPriority.toString()
            
            node_rule_list.append("SkeletonLinkageRule_Nodes(nodes: \(nodes_array_string), layoutPriority: \(prio))")
            
        }
        
        var node_rule_array_string = "["
        node_rule_array_string += node_rule_list.joined(separator: ",\n")
        node_rule_array_string += "]"
        
        
        print("let rows = [\(row_names_list.joined(separator: ", "))]")
        print("let sections = [\(section_names_list.joined(separator: ", "))]")
        print("let nodes = [\(node_names_list.joined(separator: ", "))]")
        
        print("let nodeRules = \(node_rule_array_string)")
        
        
        
        //public let nodeRules: [SkeletonLinkageRule_Nodes]
        //public let flexerRules: [SkeletonLinkageRule_Flexers]
        //public let pieceRules: [SkeletonLinkageRule_Pieces]
        
    }
}
