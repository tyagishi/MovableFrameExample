//
//  ContentView.swift
//  MovableFrameExample
//
//  Created by Tomoaki Yagishita on 2020/06/28.
//

import SwiftUI
import MovableFrame

struct ContentView: View {
    @State private var frameRect: CGRect = CGRect(origin: CGPoint.zero,
                                                  size: CGSize(width: 300, height: 200))
    @State private var canvasRect: CGRect = CGRect.zero

    var body: some View {
        ZStack {
            Image("SampleImage")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(FrameViewRectPreferenceSetter(prefName: "ImageView"))
            Text("test")
            FrameView(frameRect: $frameRect, canvasRect: canvasRect)
        }
        .border(Color.green)
        .onPreferenceChange(FrameViewRectPreferenceKey.self, perform: { prefs in
            for pref in prefs {
                if pref.name == "ImageView" {
                    self.canvasRect = pref.rect
                }
            }
        })
        .coordinateSpace(name: "mainZStack")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
