//
//  Array+OnlyOrNothing.swift
//  Memorizando
//
//  Created by Filipe Lopes on 05/08/21.
//

import Foundation

extension Array {
    var only: Element? {
        count == 1 ? first : nil
    }
}
