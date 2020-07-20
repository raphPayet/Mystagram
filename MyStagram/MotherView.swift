//
//  MotherView.swift
//  MyStagram
//
//  Created by Raphaël Payet on 18/07/2020.
//  Copyright © 2020 Oriapy. All rights reserved.
//

import SwiftUI

struct MotherView: View {
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        VStack {
            if viewRouter.isLoggedIn {
                ProfileView()
                    
            } else {
                LoginView()
                    .transition(AnyTransition.opacity.combined(with: .move(edge : .leading)))
            }
        }
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView().environmentObject(ViewRouter())
    }
}
