//
//  ContentView.swift
//  Demo
//
//  Created by zack on 2024/8/20.
//

import SwiftUI

struct ContentView: View {

    enum Method {
        case a
        case b
    }
    @State private var path = NavigationPath()
    
    @State private var selectedTab: PageTab = .a
    let tabList: [PageTab] = PageTab.allCases

    var body: some View {

        NavigationStack(path: $path) {
            
            VStack(spacing: 0) {
                
                Text("方案一")
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .onTapGesture {
                        path.append(Method.a)
                    }
                Text("方案二")
                    .frame(width: UIScreen.main.bounds.width, height: 200)
                    .onTapGesture {
                        path.append(Method.b)
                    }
            }
            .navigationDestination(for: Method.self) { method in
                
                switch method {
                case .a:
                    
                    HeaderBarPagerView(header: {

                        HStack(spacing: 0) {
                            Spacer()
                            Text("头部")
                                .frame(height: 150)
                            Spacer()
                        }
                        .background(Color.red)
                    },
                                       tabList: tabList,
                                       selectedTab: $selectedTab,
                                       tabItemHeight: 40,
                                       tabItem: { tab, isSelected in
                        Text(tab.rawValue)
                            .font(.system(size: isSelected ? 16 : 14))
                    },
                                       showSlider: true,
                                       tabEdgeInsets: EdgeInsets(top: 17, leading: 0, bottom: 12, trailing: 0),
                                       tabPage: { tab, isSelected, didScrollHandler in
                        
                        PageView(tab: tab, didScrollHandler: { offset in
                            didScrollHandler?(offset)
                        })
                    })
                case .b:
                    
                    HeaderBarPagerSynchronousView(header: {

                        HStack(spacing: 0) {
                            Spacer()
                            Text("头部")
                                .frame(height: 150)
                            Spacer()
                        }
                        .background(Color.red)
                    },
                                       tabList: tabList,
                                       selectedTab: $selectedTab,
                                       tabItemHeight: 40,
                                       tabItem: { tab, isSelected in
                        Text(tab.rawValue)
                            .font(.system(size: isSelected ? 16 : 14))
                    },
                                       showSlider: true,
                                       tabEdgeInsets: EdgeInsets(top: 17, leading: 0, bottom: 12, trailing: 0),
                                       tabPage: { tab, isSelected, didScrollHandler in
                        
                        PageView(tab: tab, didScrollHandler: { offset in
                            didScrollHandler?(offset)
                        })
                    })
                }
            }
        }
    }
}
