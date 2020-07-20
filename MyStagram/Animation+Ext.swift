//
//  Animation+Ext.swift
//  Working Animations
//
//  Created by Raphaël Payet on 18/07/2020.
//  Copyright © 2020 Oriapy. All rights reserved.
//

import SwiftUI

extension View {
    func animate(using animation : Animation = Animation.easeInOut(duration : 1), _ action : @escaping () -> Void) -> some View {
        return onAppear {
            withAnimation {
                action()
            }
        }
    }
    
    func animateForever(using animation : Animation = Animation.easeInOut(duration : 1), autoreverses: Bool = false, _ action : @escaping () -> Void) -> some View {
        let repeated = animation.repeatForever(autoreverses: autoreverses)
        
        return onAppear {
            withAnimation(repeated) {
                action()
            }
        }
    }
}
