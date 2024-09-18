//
//  ChildSizeReader.swift
//  Demo
//
//  Created by zack on 2024/9/18.
//

import SwiftUI

struct ChildSizeReader<Content: View>: View {

    @Binding var size: CGSize
    let content: () -> Content

    var body: some View {

        ZStack {

            content()
                .background(
                    GeometryReader { geometry in
                        Color.clear
                            .preference(key: CGSizePreferenceKey.self, value: geometry.size)
                            .onPreferenceChange(CGSizePreferenceKey.self) { preferences in
                                self.size = preferences
                            }
                    }
                )
        }
    }
}
