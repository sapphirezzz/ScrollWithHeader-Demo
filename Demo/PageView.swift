//
//  PageView.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct PageView: View {

    /// 参数
    let tab: PageTab
    let didScrollHandler: (_ offset: CGFloat) -> Void

    @Namespace private var scrollViewSpace

    var body: some View {
        
        ScrollView(.vertical) {
            
            ScrollViewOffsetObserver(scrollViewSpace: scrollViewSpace,
                                     axis: .vertical,
                                     onChangeHandler: { value in
                didScrollHandler(value)
            })

            switch tab {
            case .a:
                Color.yellow
                    .frame(width: UIScreen.main.bounds.width, height: 400)
            case .b:
                Color.cyan
                    .frame(width: UIScreen.main.bounds.width, height: 600)
            case .c:
                Color.orange
                    .frame(width: UIScreen.main.bounds.width, height: 1500)
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white)
        .coordinateSpace(name: scrollViewSpace)
    }
}
