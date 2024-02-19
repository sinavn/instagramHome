//
//  Drag.swift
//  instagramHome
//
//  Created by Sina Vosough Nia on 11/30/1402 AP.
//

import SwiftUI

struct Drag: View {
    @State var isTapped = "oo"
    @State var opacityClear : Bool = false
//    @State var timerBool : Bool = false
    var body: some View {
        VStack{
            ZStack(content: {
                Rectangle().fill(.black)
                    .overlay {
                        Rectangle().fill(.red)
                            .frame(width: 100)
                        
                    }
                Rectangle().fill(.blue.opacity(opacityClear ? 0.0 : 0.5))
                    .frame(width: 400 , height: 600)
                    ._onButtonGesture { _ in
                        opacityClear = true
                    } perform: {
                        opacityClear = false
                    }

            })
       Text(isTapped)
        }
    }
}

#Preview {
    Drag()
}
