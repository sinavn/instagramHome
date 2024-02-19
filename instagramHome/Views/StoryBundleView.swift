//
//  StoryTabView.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import SwiftUI

struct StoryBundleView: View {
    @EnvironmentObject var vm : StoryViewModel 
    var body: some View {
        
        if vm.showStory{
            TabView(selection: $vm.currentStory, content: {
                ForEach($vm.stories) { $story in
                    StoryContentView(storyBundle: $story)
                }
            })
            .tabViewStyle(.page(indexDisplayMode: .never))
            .frame(maxWidth: .infinity , maxHeight: .infinity ,alignment: .center)
            .background(.black)
            .transition(.move(edge: .bottom))
            
        }
    }
}


#Preview {
    StoryBundleView()
        .environmentObject(StoryViewModel())
}
