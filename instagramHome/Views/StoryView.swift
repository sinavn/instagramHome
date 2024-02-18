//
//  StoryTabView.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import SwiftUI

struct StoryView: View {
    @EnvironmentObject var vm : StoryViewModel 
    var body: some View {
        
        if vm.showStory{
            TabView(selection: $vm.currentStory, content: {
                ForEach($vm.stories) { $story in
                    CubeTransitionView(storyBundle: $story)
                        .onAppear(perform: {
                            
                        })
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
    StoryView()
        .environmentObject(StoryViewModel())
}
