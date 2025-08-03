//
//  SkeletonLayoutGrouper.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

public struct SkeletonLayoutGrouper {
    
    static func getAllSections(pages: [SkeletonPage]) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    result.append(section)
                }
            }
        }
        return result
    }
    
    static func getAllNodes(pages: [SkeletonPage]) -> [SkeletonNode] {
        var result = [SkeletonNode]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        result.append(node)
                    }
                }
            }
        }
        return result
    }
    
    static func getAllChunks(pages: [SkeletonPage]) -> [any SkeletonChunkConforming] {
        var result = [any SkeletonChunkConforming]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            result.append(chunk)
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getAllPieces(pages: [SkeletonPage]) -> [SkeletonPiece] {
        var result = [SkeletonPiece]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for piece in chunk.pieces {
                                result.append(piece)
                            }
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getAllFlexers(pages: [SkeletonPage]) -> [Flexer] {
        var result = [Flexer]()
        for page in pages {
            for row in page.rows {
                for section in row.sections {
                    for node in section.skeletonNodes {
                        for chunk in node.chunks {
                            for flexer in chunk.flexers {
                                result.append(flexer)
                            }
                        }
                    }
                }
            }
        }
        return result
    }
    
    public static func getPieceGroups(pages: [SkeletonPage],
                                      rules: [SkeletonLinkageRule_Pieces]) -> [ExploderGroup<SkeletonPiece>] {
        let pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: pieces, links: links)
        
        for group in result {
            for piece in group.linkedList {
                piece.group = group
            }
        }
        
        return result
    }
    
    public static func getFlexerGroups(pages: [SkeletonPage],
                                       rules: [SkeletonLinkageRule_Flexers]) -> [ExploderGroup<Flexer>] {
        let flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: flexers, links: links)
        
        for group in result {
            for flexer in group.linkedList {
                flexer.group = group
            }
        }
        
        return result
    }
    
    public static func getChunkGroups(pages: [SkeletonPage],
                                      rules: [SkeletonLinkageRule_Chunks]) -> [ExploderGroupChunks] {
        let chunks = SkeletonLayoutGrouper.getAllChunks(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = ExploderChunks.explode(nodes: chunks, links: links)
        
        for group in result {
            for node in group.linkedList {
                node.group = group
            }
        }
        
        return result
    }
    
    public static func getNodeGroups(pages: [SkeletonPage],
                                     rules: [SkeletonLinkageRule_Nodes]) -> [ExploderGroup<SkeletonNode>] {
        let nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: nodes, links: links)
        
        for group in result {
            for node in group.linkedList {
                node.group = group
            }
        }
        
        return result
    }
    
    public static func getSectionGroups(pages: [SkeletonPage],
                                        rules: [SkeletonLinkageRule_Sections]) -> [ExploderGroup<SkeletonSection>] {
        let sections = SkeletonLayoutGrouper.getAllSections(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(nodes: sections, links: links)
        
        for group in result {
            for section in group.linkedList {
                section.group = group
            }
        }
        
        return result
    }
    
}
