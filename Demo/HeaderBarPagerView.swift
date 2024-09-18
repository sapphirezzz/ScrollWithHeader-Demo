//
//  HeaderBarPagerView.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct HeaderBarPagerView<Header: View, Tab: Hashable, TabItem: View, TabPage: View>: View {

    /// 参数
    var header: () -> Header

    let tabList: [Tab]
    @Binding var selectedTab: Tab
    let tabItemHeight: CGFloat
    let tabItem: (_ tab: Tab, _ isSelected: Bool) -> TabItem
    let showSlider: Bool
    let tabEdgeInsets: EdgeInsets
    let tabPage: (_ tab: Tab, _ isSelected: Bool, _ didScroll: ((CGFloat) -> Void)?) -> TabPage
    
    /// 其他
    @State private var headerSize: CGSize = .zero
    
    /// 手势
    @GestureState private var dragValue: CGSize = .zero
    @State private var preDragValue = CGSize.zero

    var body: some View {

        VStack(spacing: 0) {
            
            ZStack(alignment: .bottom) {
                ChildSizeReader(size: $headerSize) {
                    self.header()
                }
            }
            .frame(height: min(max(headerSize.height + preDragValue.height + dragValue.height, 0), headerSize.height))

            BarPagerView(tabList: tabList,
                         selectedTab: $selectedTab,
                         tabItemHeight: tabItemHeight,
                         tabItem: tabItem,
                         showSlider: showSlider,
                         tabEdgeInsets: tabEdgeInsets,
                         tabPage: { tab, isSelected in

                tabPage(tab, isSelected, { offset in
                    
                    if offset < 0 {
                        withAnimation {
                            self.preDragValue.height = 0
                        }
                    }
                })
                .scrollDisabled(headerSize.height + dragValue.height + preDragValue.height > 0)
            })
        }
        .gesture(
            
            DragGesture()
                .updating($dragValue, body: { value, state, _ in
                    state = value.translation
                })
                .onEnded { value in
                    
                    let newDragHeight = self.preDragValue.height + value.translation.height
                    let oldDragHeight = self.preDragValue.height
                    self.preDragValue.height = newDragHeight
                    withAnimation {
                        self.preDragValue.height = newDragHeight > oldDragHeight ? 0 : -headerSize.height
                    }
                }
        )
    }
}
