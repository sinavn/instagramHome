//
//  ContentView.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import SwiftUI

struct HomePageView: View {
    @StateObject var vm = StoryViewModel()
    var body: some View {
        
        ZStack {
            ScrollView(.vertical , showsIndicators: false) {
                HStack {
                    Text("Instagram")
                        .frame(maxWidth: .infinity, alignment: .leading )
                        .font(.largeTitle)
                        .padding(.horizontal)
                    Image(systemName: "suit.heart")
                    Image(systemName: "paperplane")
                        .padding()
                }
                // stories scroll view
                ScrollView (.horizontal,showsIndicators: false){
                    HStack{
                        ForEach($vm.stories) { $account in
                            ProfileView(account: $account)
                                .onTapGesture {
                                    withAnimation(){
                                        vm.currentStory=$account.id
                                        vm.showStory = true
                                    }
                                }
                        }
                    }
                }
                //posts
                VStack{
                    ForEach(0..<10, content: {_ in 
                        RoundedRectangle(cornerRadius: 5)
                            .frame(height: 500)
                            .padding()
                    })
                }
            }
            
        }
        // show story view if toggled
        .overlay(content: {
            StoryBundleView()
                .environmentObject(vm)
        })
        .ignoresSafeArea(edges: .bottom)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            HomePageView()
        }
    }
}
