//
//  StoryViewModel.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/26/1402 AP.
//

import Foundation
import SwiftUI
class StoryViewModel:ObservableObject {
    //list of stories
    @Published var stories : [StoryModel] = [
    StoryModel(accountName: "SinaVn", accountImage: "profile2", stories:
                [Story(imageURL: "pic1"),
                Story(imageURL: "pic2"),
                Story(imageURL: "pic3")]) ,
    StoryModel(accountName: "Mmd", accountImage: "profile1", stories:
                [Story(imageURL: "pic4"),
                Story(imageURL: "pic5")])
    ]
    
    @Published var showStory: Bool = false
    
    @Published var currentStory : String = ""
    
    
    
    func getAngle(geo:GeometryProxy)->Angle{
        let progress = geo.frame(in: .global).minX / geo.size.width
        return Angle(degrees: Double(45*progress))
    }
}
