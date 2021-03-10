//
//  ContentView.swift
//  MovableFrameExample
//
//  Created by Tomoaki Yagishita on 2020/06/28.
//

import SwiftUI
import MovableFrame
import SDSCGExtension
import SwiftUIDebugUtil

struct ContentView: View {
    @State private var frameRect: CGRect = CGRect(origin: CGPoint.zero,
                                                  size: CGSize(width: 300, height: 200))
    @State private var canvasRect: CGRect = CGRect.zero
    
    @State private var nsImage: NSImage = NSImage(named: "SampleImage")!

    var body: some View {
        ZStack {
            Image(nsImage: nsImage)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(FrameViewRectPreferenceSetter(prefName: "ImageView"))
                .debugBorder(Color.yellow, width: 3)
            FrameView(frameRect: $frameRect, canvasRect: canvasRect)
        }
        .debugBorder(.red, width: 4)
        .onPreferenceChange(FrameViewRectPreferenceKey.self, perform: { prefs in
            for pref in prefs {
                if pref.name == "ImageView" {
                    self.canvasRect = nsImage.size.placeInSizedCanvas(pref.rect.size)
                }
            }
        })
        .coordinateSpace(name: "FrameViewCoordinate")
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
