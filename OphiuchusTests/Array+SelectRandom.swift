//
//  Array+SelectRandom.swift
//  OphiuchusTests
//
//  Created by Nick on 7/9/25.
//

import Foundation

func getRandomElements<Element>(input: [Element], count: Int)  -> [Element] {
    
    var result = [Element]()
    var input = input
    input.shuffle()
    var index = 0
    while index < count && index < input.count {
        result.append(input[index])
        index += 1
    }
    return result
}
