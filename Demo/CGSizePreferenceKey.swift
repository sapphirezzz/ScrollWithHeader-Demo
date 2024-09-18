//
//  CGSizePreferenceKey.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct CGSizePreferenceKey: PreferenceKey {
 
    typealias Value = CGSize
    static var defaultValue: Value = .zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value = nextValue()
    }
}
