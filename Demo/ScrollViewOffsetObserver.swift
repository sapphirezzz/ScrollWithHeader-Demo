//
//  ScrollViewOffsetObserver.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct ScrollViewOffsetObserver: View {

    /// 参数
    let scrollViewSpace: AnyHashable
    let axis: Axis.Set
    let onChangeHandler: (CGFloat) -> Void

    var body: some View {
        
        Color.clear
            .frame(width: 0, height: 0)
            .background( GeometryReader { geometry in

                let frame = geometry.frame(in: .named(scrollViewSpace))
                Color.clear.preference(key: CGFloatPreferenceKey.self,
                                       value: axis == .horizontal ? -frame.minX : -frame.minY)
            })
            .onPreferenceChange(CGFloatPreferenceKey.self) { value in
                onChangeHandler(value)
            }
    }
}
