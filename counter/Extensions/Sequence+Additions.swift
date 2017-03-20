//
//  Sequence+Additions.swift
//  NZKit
//
//  Created by Nik Zakirin on 20/03/2017.
//  Copyright © 2017 zaria. All rights reserved.
//

import Foundation

extension Sequence where Self.Iterator.Element: Hashable {
    private typealias Element = Self.Iterator.Element
    
    func freq() -> [Element: Int] {
        return reduce([:]) { (accu: [Element: Int], element) in
            var accu = accu
            accu[element] = accu[element]?.advanced(by: 1) ?? 1
            return accu
        }
    }
}

extension Sequence where Self.Iterator.Element: Equatable {
    private typealias Element = Self.Iterator.Element
    
    func freqTuple() -> [(element: Element, count: Int)] {
        
        let empty: [(Element, Int)] = []
        
        return reduce(empty) { (accu: [(Element, Int)], element) in
            var accu = accu
            for (index, value) in accu.enumerated() {
                if value.0 == element {
                    accu[index].1 += 1
                    return accu
                }
            }
            
            return accu + [(element, 1)]
        }
    }
}
