//
//  instagramHomeApp.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import SwiftUI

@main
struct instagramHomeApp: App {
    @StateObject  var vm = StoryViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack{
                HomePageView()
            .environmentObject(vm)
            }
            }
    }
}
