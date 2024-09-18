//
//  HeaderBarPagerSynchronousView.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct HeaderBarPagerSynchronousView<Header: View, Tab: Hashable, TabItem: View, TabPage: View>: View {

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

    @State private var preDragValue = CGSize.zero

    var body: some View {

        VStack(spacing: 0) {
            
            ZStack(alignment: .bottom) {
                ChildSizeReader(size: $headerSize) {
                    self.header()
                }
            }
            .frame(height: min(max(headerSize.height + preDragValue.height, 0), headerSize.height))

            BarPagerView(tabList: tabList,
                         selectedTab: $selectedTab,
                         tabItemHeight: tabItemHeight,
                         tabItem: tabItem,
                         showSlider: showSlider,
                         tabEdgeInsets: tabEdgeInsets,
                         tabPage: { tab, isSelected in

                tabPage(tab, isSelected, { offset in
                    self.preDragValue.height = -offset
                })
            })
        }
    }
}
