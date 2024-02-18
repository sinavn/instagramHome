//
//  StoryModel.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import Foundation
struct StoryModel : Identifiable , Hashable {
    var id = UUID().uuidString
    var accountName: String
    var accountImage: String
    var isSeen :Bool = false
    var stories : [Story]
}
struct Story : Identifiable , Hashable{
    var id = UUID().uuidString
    var imageURL : String
}
