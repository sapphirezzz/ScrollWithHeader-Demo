//
//  BarPagerView.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct BarPagerView<Tab: Hashable, TabItem: View, TabPage: View>: View {
    
    let tabList: [Tab]
    @Binding var selectedTab: Tab
    let tabItemHeight: CGFloat
    let tabItem: (_ tab: Tab, _ isSelected: Bool) -> TabItem
    let showSlider: Bool
    let tabEdgeInsets: EdgeInsets
    let tabPage: (_ tab: Tab, _ isSelected: Bool) -> TabPage

    var body: some View {
        
        GeometryReader { geometry in
            
            VStack(spacing: 0) {

                ScrollViewReader { scrollView in
                    /// 选项卡
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        HStack(spacing: 0) {
                            
                            if !tabList.isEmpty {
                                
                                let tabWidth = geometry.size.width / CGFloat(tabList.count)
                                ForEach(tabList, id: \.self) { tab in
                                    
                                    let isSelected = tab == selectedTab
                                    ZStack {
                                        
                                        tabItem(tab, isSelected)
                                            .background(showSlider && isSelected ? VStack(spacing: 0) {
                                                Spacer()
                                                Color.yellow
                                                    .frame(width: 45, height: 8)
                                                    .clipShape(RoundedRectangle(cornerRadius: 4))
                                            } : nil)
                                    }
                                    .padding(tabEdgeInsets)
                                    .frame(width: tabWidth, height: tabItemHeight)
                                    .contentShape(Rectangle())
                                    .onTapGesture {
                                        selectedTab = tab
                                    }
                                }
                            }
                        }
                        .background(Color.white)
                    }
                    .scrollDisabled(true)
                    .frame(height: tabItemHeight)
                    .onChange(of: selectedTab) { newValue in
                        withAnimation {
                            scrollView.scrollTo(newValue, anchor: .center)
                        }
                    }
                }

                /// 页面内容
                TabView(selection: $selectedTab) {

                    ForEach(tabList, id: \.self) { tab in

                        let isSelected = tab == selectedTab
                        tabPage(tab, isSelected)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                Spacer()
            }
        }
    }
}
