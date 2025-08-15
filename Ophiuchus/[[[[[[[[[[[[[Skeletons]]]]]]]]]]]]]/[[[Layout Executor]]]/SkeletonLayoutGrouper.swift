//
//  SkeletonLayoutGrouper.swift
//  Ophiuchus
//
//  Created by Nick on 8/2/25.
//

import Foundation

public struct SkeletonLayoutGrouper {
    
    static func getAll(book: SkeletonBook) -> SkeletonLayoutGroupDataExploded {
        
        let pieces = SkeletonLayoutGrouper.getPieceGroups(baseId: 1000,
                                                          pages: book.pages,
                                                          rules: book.pieceRules)
        
        
        let flexers = SkeletonLayoutGrouper.getFlexerGroups(baseId: 2000,
                                                            pages: book.pages,
                                                            rules: book.flexerRules)
        let nodes = SkeletonLayoutGrouper.getNodeGroups(baseId: 3000, pages:
                                                            book.pages,
                                                        rules: book.nodeRules)
        let sections = SkeletonLayoutGrouper.getAllSections(pages: book.pages)
        let result = SkeletonLayoutGroupDataExploded(pieceGroups: pieces,
                                                     flexerGroups: flexers,
                                                     nodeGroups: nodes,
                                                     sections: sections)
        return result
    }
    
    static func getAllSections(pages: [SkeletonPage]) -> [SkeletonSection] {
        var result = [SkeletonSection]()
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    result.append(_section)
                }
            }
        }
        return result
    }
    
    static func getAllNodes(pages: [SkeletonPage]) -> [WiseLayoutNode] {
        var result = [WiseLayoutNode]()
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    for _node in _section.nodes {
                        result.append(_node)
                    }
                }
            }
        }
        return result
    }
    
    static func getAllPieces(pages: [SkeletonPage]) -> [SkeletonPiece] {
        var result = [SkeletonPiece]()
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    for _node in _section.nodes {
                        for _piece in _node.pieces {
                            result.append(_piece)
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getAllFlexers(pages: [SkeletonPage]) -> [Flexer] {
        var result = [Flexer]()
        for _page in pages {
            for _row in _page.rows {
                for _section in _row.sections {
                    for _node in _section.nodes {
                        for _flexer in _node.flexers {
                            result.append(_flexer)
                        }
                    }
                }
            }
        }
        return result
    }
    
    static func getPieceGroups(baseId: Int,
                               pages: [SkeletonPage],
                               rules: [SkeletonLinkageRule_Pieces]) -> [ExploderGroup<SkeletonPiece>] {
        let pieces = SkeletonLayoutGrouper.getAllPieces(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(baseId: baseId,
                                      nodes: pieces,
                                      links: links)
        
        for group in result {
            for piece in group.linkedList {
                piece.group = group
            }
        }
        
        return result
    }
    
    static func getFlexerGroups(baseId: Int,
                                pages: [SkeletonPage],
                                rules: [SkeletonLinkageRule_Flexers]) -> [ExploderGroup<Flexer>] {
        let flexers = SkeletonLayoutGrouper.getAllFlexers(pages: pages)
        
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(baseId: baseId,
                                      nodes: flexers,
                                      links: links)
        for group in result {
            for flexer in group.linkedList {
                flexer.group = group
            }
        }
        
        return result
    }
    
    static func getNodeGroups(baseId: Int,
                              pages: [SkeletonPage],
                              rules: [SkeletonLinkageRule_Nodes]) -> [ExploderGroup<WiseLayoutNode>] {
        let nodes = SkeletonLayoutGrouper.getAllNodes(pages: pages)
        var links = [ExploderLink]()
        for rule in rules {
            let rule_links = rule.getLinks()
            links.append(contentsOf: rule_links)
        }
        let result = Exploder.explode(baseId: baseId,
                                      nodes: nodes,
                                      links: links)
        
        for group in result {
            for node in group.linkedList {
                node.group = group
            }
        }
        
        return result
    }
    
}
