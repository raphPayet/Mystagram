//
//  LoginView.swift
//  MyStagram
//
//  Created by Raphaël Payet on 18/07/2020.
//  Copyright © 2020 Oriapy. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    
    @State var email        : String = ""
    @State var emailIsOk    = false
    
    @State var password     : String = ""
    @State var passwordIsOk = false
    
    @State var face1OffsetX = CGFloat(0)
    @State var face1OffsetY = CGFloat(0)
    
    @State var face2OffsetX = CGFloat(0)
    @State var face2OffsetY = CGFloat(0)
    
    @State var face3OffsetX = CGFloat(0)
    @State var face3OffsetY = CGFloat(0)
    
    @State var face4OffsetX = CGFloat(0)
    @State var face4OffsetY = CGFloat(0)
    
    @State var face5OffsetX = CGFloat(0)
    @State var face5OffsetY = CGFloat(0)
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    
    var body: some View {
        VStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.white)
                    .frame(height : screen.height * 1/3)
                    .edgesIgnoringSafeArea(.all)
                PersonImageView(image: 4, width: 50, height: 50)
                    .offset(x : 60, y : -50)
                    .offset(x : face4OffsetX, y : face4OffsetY)
                    .blur(radius: 5)
                    .animateForever(using: Animation.easeIn(duration : 5), autoreverses: true) {
                        self.face4OffsetX += -60 - screen.width / 2 + 50
                        self.face4OffsetY += ((screen.height * 1/3)) / 2
                }
                PersonImageView(image: 1, width: 100, height: 100)
                    .offset(x : face1OffsetX, y : face1OffsetY)
                    .animateForever(using:  Animation.easeIn(duration : 5), autoreverses: true) {
                        self.face1OffsetY += -((screen.height * 1/3) / 2) + 50
                        self.face1OffsetX += (screen.width / 2) - 100
                }
                PersonImageView(image: 2, width: 50, height: 50)
                    .offset(x : -(screen.width / 2) + 50, y : -100)
                    .offset(x : face2OffsetX, y : face2OffsetY)
                    .animateForever(using: Animation.easeIn(duration : 5), autoreverses: true) {
                        self.face2OffsetX += screen.width / 2 - 50
                        self.face2OffsetY += -100 + screen.height * 1/3
                }
                PersonImageView(image: 3, width: 50, height: 50)
                    .offset(x : -100, y : 70)
                    .offset(x : face3OffsetX, y : face3OffsetY)
                    .animateForever(using: Animation.easeIn(duration : 5), autoreverses: true) {
                        self.face3OffsetX += 50 + screen.width / 2
                        self.face3OffsetY += -50
                }
                PersonImageView(image: 4, width: 50, height: 50)
                    .offset(x : screen.width / 2 - 50, y : 100)
                    .offset(x : face5OffsetX, y : face5OffsetY)
                    .animateForever(using: Animation.easeIn(duration: 5), autoreverses: true) {
                        self.face5OffsetX += -(screen.width / 2 - 50) - 50
                        self.face5OffsetY += -(screen.height * 1/3) + 50
                }
                
            }
            
            
            CustomTextField(email : $email, emailIsOk: $emailIsOk, placeholder: "your email", icon: "person")
            
            CustomPasswordField(password: $password, passwordIsOk: $passwordIsOk, placeholder: "your password", icon: "lock")
            
            Button(action : {
                if !self.email.isEmpty {
                    self.emailIsOk = true
                }
                
                if !self.password.isEmpty {
                    self.passwordIsOk = true
                }
                
                
                if self.emailIsOk && self.passwordIsOk {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        withAnimation(.easeInOut(duration : 0.5)) {
                            self.viewRouter.isLoggedIn = true
                        }
                    }
                }
                
                
            }) {
                LoginButton()
            }
            Spacer()
            Image(systemName: "faceid")
                .resizable()
                .frame(width : 80, height : 80)
                .foregroundColor(Color.black.opacity(0.4))
            
            Text("Face ID")
                .font(.headline)
            Text("Log in using Face ID")
                .font(.body)
                .foregroundColor(Color.black.opacity(0.7))
            
            Spacer()
            Text("Don't have an account ? Sign Up")
                .font(.headline)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environmentObject(ViewRouter())
    }
}

struct CustomTextField: View {
    
    @Binding var email : String
    @Binding var emailIsOk : Bool
    
    var placeholder : String
    var icon : String
    
    var body: some View {
        VStack(spacing : -5) {
            HStack {
                Text("\(placeholder) *")
                    .font(.caption)
                Spacer()
            }
            .padding(.leading, 8)
            
            
            HStack {
                Image(systemName: icon)
                
                TextField("", text: $email)
                    .frame(height : 50)
                
                Image(systemName: "checkmark")
                    .foregroundColor(emailIsOk ? .green : .white)
                    .opacity(emailIsOk ? 1 : 0)
                    .animation(.easeInOut(duration : 0.5))
            }.padding(.horizontal, 8)
            
            RoundedRectangle(cornerRadius : 1)
                .frame(height : 2)
                .foregroundColor(Color.black.opacity(0.3))
                .padding(.horizontal, 8)
        }
    }
}


struct CustomPasswordField: View {
    
    @Binding var password : String
    @Binding var passwordIsOk : Bool
    
    var placeholder : String
    var icon : String
    
    var body: some View {
        VStack(spacing : -5) {
            HStack {
                Text("\(placeholder) *")
                    .font(.caption)
                Spacer()
            }
            .padding(.leading, 8)
            
            
            HStack {
                Image(systemName: icon)
                
                SecureField("", text: $password)
                    .frame(height : 50)
                
                
                Image(systemName: "checkmark")
                    .foregroundColor(passwordIsOk ? .green : .white)
                    .opacity(passwordIsOk ? 1 : 0)
                    .animation(.easeInOut(duration : 0.5))
            }.padding(.horizontal, 8)
            
            RoundedRectangle(cornerRadius : 1)
                .frame(height : 2)
                .foregroundColor(Color.black.opacity(0.3))
                .padding(.horizontal, 8)
        }
    }
}

struct LoginButton: View {
    var body: some View {
        Text("Log In")
            .font(.system(size: 20, weight: .regular, design: .rounded))
            .foregroundColor(.white)
            .frame(width : 130, height : 50)
            .background(myBlue)
            .cornerRadius(20)
    }
}

struct PersonImageView: View {
    
    var image : Int
    var width : CGFloat
    var height : CGFloat
    
    var body: some View {
        Image("face\(image)")
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width : width, height : height)
            .cornerRadius(width / 5)
            .shadow(color: .black, radius: width / 5, x: 0, y: width / 5)
    }
}
