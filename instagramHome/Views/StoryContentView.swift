//
//  CubeTransitionView.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/27/1402 AP.
//

import SwiftUI

struct StoryContentView: View {
    @Binding var storyBundle : StoryModel
    @EnvironmentObject var vm : StoryViewModel
    @State var timerProgress : CGFloat = 0
    @State var isSwapped : Bool = false
    @State var layerOpacIsClear = 1.0
    //timer
    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    var body: some View {
        GeometryReader { geo in
            ZStack{
                //getting current index and update data
                let index = min(Int(timerProgress), storyBundle.stories.count - 1)
                Image(storyBundle.stories[index].imageURL)
                    .resizable()
                    .frame(maxWidth: .infinity , maxHeight: .infinity , alignment: .center)
            }
            // stop timer if swapping
            .onChange(of: geo.frame(in: .global).minX, { oldValue, newValue in
                if newValue != 0.0 {
                    timer.upstream.connect().cancel()
                }else{
                    timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                }
            })
            .background(.black)
            
            // front layer
            .overlay(content: {
                HStack{

            //backward
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .gesture(
                            TapGesture()
                            
                                .onEnded({ _ in
                                    if (timerProgress - 1) < 0 {
                                        updateStory(isForward: false)
                                    }else{
                                        timerProgress = CGFloat(Int(timerProgress - 1))
                                    }
                                })
                        )
                    
            //forward
                    Rectangle()
                        .fill(.black.opacity(0.01))
                        .gesture(
                            TapGesture()
                                .onEnded({ _ in
                                    if (timerProgress + 1) > CGFloat(storyBundle.stories.count){
                                        updateStory()
                                    }else{
                                        timerProgress = CGFloat(Int(timerProgress + 1))
                                    }
                                })
                        )
                }
    // hold story func
                ._onButtonGesture { isPressed in
                    if isPressed{
                        withAnimation() {
                            layerOpacIsClear = 0
                        }
                        timer.upstream.connect().cancel()
                    }else{
                       
                        
                        withAnimation() {
                            layerOpacIsClear = 1
                        }
                        timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
                    }
                } perform: {}
                
                // profile and x button
                    .overlay(alignment:.topTrailing ){
                        HStack(spacing:15){
                            //profile
                            Image(storyBundle.accountImage)
                                .resizable()
                                .frame(width: 35 , height: 35)
                                .clipShape(Circle())
                            Text(storyBundle.accountName)
                                .foregroundStyle(.white)
                            
                            Spacer()
                            // close button X
                            Button(action: {
                                withAnimation {
                                    vm.showStory = false
                                }
                            }, label: {
                                Image(systemName: "xmark")
                                    .foregroundStyle(.white)
                            })
                        }
                        .bold()
                        .font(.title2)
                        .padding()
                    }
                //stories indicator capsule
                    .overlay(alignment: .top, content: {
                        HStack(spacing:5){
                            ForEach(storyBundle.stories.indices,id: \.self) { index in
                                GeometryReader{geo in
                                    
                                    let width = geo.size.width
                                    let progress = min(max(timerProgress - CGFloat(index), 0), 1)
                                    
                                    Capsule()
                                        .fill(.gray.opacity(0.7))
                                        .overlay(alignment: .leading,content: {
                                            Capsule()
                                                .fill(.white)
                                                .frame(width: width * progress)
                                        })
                                }
                            }
                        }
                        .frame(height: 2)
                        .padding(5)
                    })
                    .opacity(layerOpacIsClear )
                
            }
            )
            
            //3d rotatation
            .rotation3DEffect(
                vm.getAngle(geo: geo)
                ,
                axis: /*@START_MENU_TOKEN@*/(x: 0.0, y: 1.0, z: 0.0)/*@END_MENU_TOKEN@*/,
                anchor: geo.frame(in: .global).minX > 0 ?
                    .leading : .trailing,
                perspective: 2
            )
        }
        
        .onAppear(perform: {
            timerProgress = 0
        })
        
        .onReceive(timer, perform: { _ in
            //update seen status
            if vm.currentStory == storyBundle.id{
                if !storyBundle.isSeen{
                    withAnimation {
                        storyBundle.isSeen = true
                    }
                }
                if timerProgress < CGFloat(storyBundle.stories.count){
                    withAnimation {
                        timerProgress += 0.03
                        
                    }
                }else{
                    updateStory()
                }
            }
            
        })
        
    }
    
    func updateStory (isForward : Bool = true){
        let index = min(Int(timerProgress), storyBundle.stories.count - 1)
        let story = storyBundle.stories[index]
        
        //if it is not first , go backward . else set timer to 0
        if !isForward{
            if let first = vm.stories.first , first.id != storyBundle.id {
                let storyBundleIndex = vm.stories.firstIndex(where: {$0.id == storyBundle.id}) ?? 0
                withAnimation {
                    vm.currentStory = vm.stories[storyBundleIndex - 1].id
                }
            }
            
            return
        }
        if let last = storyBundle.stories.last , last.id == story.id{
            if let lastAccount =  vm.stories.last , lastAccount.id == storyBundle.id {
                withAnimation {
                    vm.showStory = false
                }
                timerProgress = 0
            }else{
                // forward to next account
                let storyBundelIndex = vm.stories.firstIndex(where: {$0.id == storyBundle.id}) ?? 0
                withAnimation {
                    vm.currentStory = vm.stories[storyBundelIndex + 1].id
                }
            }
        }
    }
    
    //#Preview {
    //    CubeTransitionView(story: <#Binding<StoryModel>#>)
    //}
}

