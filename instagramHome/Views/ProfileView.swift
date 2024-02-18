//
//  accIconView.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/25/1402 AP.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var account : StoryModel
    
    var body: some View {
//        NavigationStack{
//            NavigationLink(destination: {
////                StoryItemsTabView()
//            },
//            //label
//               label: {
//              
//            })
//        }
        ZStack{
            //user profile
            Image("\(account.accountImage)")
                .resizable()
                .frame(width: 100 , height: 100)
                .clipShape(Circle())
                .padding()
            // isSeen indicator
            Circle().stroke(
                account.isSeen == true ?
                LinearGradient(gradient: Gradient(colors: [Color.gray]), startPoint: .leading  , endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/) :
                    (LinearGradient(gradient: Gradient(colors: [Color.orange,Color.red, Color.purple]), startPoint: .leading  , endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)),
                    lineWidth: 3)
                .frame(width: 120 , height: 120)
                .opacity(account.isSeen ? 0.5 : 1)
                
        }
    }
}

#Preview {
    ProfileView(account: .constant( StoryModel(accountName: "SinaVn", accountImage: "profile2", stories:
               [Story(imageURL: "pic1"),
                Story(imageURL: "pic2"),
                Story(imageURL: "pic3")])))
}
