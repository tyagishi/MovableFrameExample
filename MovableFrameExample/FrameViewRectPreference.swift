//
//  RectPreference.swift
//  MovableFrameExample
//
//  Created by Tomoaki Yagishita on 2020/06/29.
//

import Foundation
import SwiftUI

struct FrameViewRectPreferenceData: Equatable {
    let name: String
    let rect: CGRect
}

struct FrameViewRectPreferenceKey: PreferenceKey {
    typealias Value = [FrameViewRectPreferenceData]
    
    static var defaultValue:[FrameViewRectPreferenceData] = []
    
    static func reduce(value: inout [FrameViewRectPreferenceData], nextValue: () -> [FrameViewRectPreferenceData]) {
        value.append(contentsOf: nextValue())
    }
}

struct FrameViewRectPreferenceSetter: View {
    let prefName: String
    var body: some View {
        GeometryReader { geom in
            Rectangle()
                .fill(Color.clear)
                .preference(key: FrameViewRectPreferenceKey.self,
                            value: [FrameViewRectPreferenceData(name: self.prefName, rect: geom.frame(in: .named("mainZStack")))])
        }
    }
}
