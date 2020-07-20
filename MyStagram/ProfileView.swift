//
//  ProfileView.swift
//  MyStagram
//
//  Created by Raphaël Payet on 18/07/2020.
//  Copyright © 2020 Oriapy. All rights reserved.
//

import SwiftUI

let screen = UIScreen.main.bounds
let myBlue = Color(red: 26/255, green: 25/255, blue: 237/255)

struct ProfileView: View {
    
    let followers = 915
    let following = 1065
    
    @State var photoGridIsActive = true
    
    @EnvironmentObject var viewRouter : ViewRouter
    
    var body: some View {
        ScrollView(.vertical) {
            VStack {
                HStack() {
                    FollowCount(followers: followers, text: "followers")
                    Spacer()
                    AvatarView(imageName : "my_avatar")
                    Spacer()
                    FollowCount(followers: following, text: "following")
                }.padding()
                
                VStack() {
                    Text("raphbmx")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 8)
                    
                    Text("Junior iOS Dev")
                        .font(.headline)
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    HStack {
                        Image(systemName: "mappin.and.ellipse")
                            .foregroundColor(.secondary)
                        Text("Marseille, France")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                
                HStack(spacing : 30) {
                    ButtonTitle(text : "Follow", textColor: .white)
                        .background(myBlue)
                        .cornerRadius(20)
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                            .stroke()
                            .frame(width : 130, height : 50)
                        
                        Text("Message")
                            .font(.system(size: 20, weight: .regular, design : .rounded))
                            .foregroundColor(Color.black.opacity(0.7))
                    }
                    
                }
                
                VStack {
                    HStack {
                        Button(action : {
                            withAnimation {
                                self.photoGridIsActive.toggle()
                            }
                        }) {
                            GridButtonContent(photoGridIsActive: $photoGridIsActive, imageName: "photo")
                        }
                        Button(action : {
                            withAnimation {
                                self.photoGridIsActive.toggle()
                            }
                        }) {
                            GridButtonContent(photoGridIsActive: $photoGridIsActive, imageName: "bookmark")
                        }
                    }.frame(width: screen.width, height : 50)
                    
                    Rectangle()
                        .frame(width : screen.width / 2 - 20, height : 2)
                        .offset(x : photoGridIsActive ? -screen.width / 4 : screen.width / 4)
                        .animation(.easeInOut)
                }
                
                if photoGridIsActive {
                    HStack(alignment : .top) {
                        VStack {
                            MyStaImage(number: 1)
                            MyStaImage(number: 4)
                            MyStaImage(number: 9)
                        }
                        VStack {
                            MyStaImage(number : 3)
                            MyStaImage(number : 5)
                            MyStaImage(number: 7)
                        }
                        
                        VStack {
                            MyStaImage(number: 2)
                            MyStaImage(number: 6)
                            MyStaImage(number: 3)
                        }
                    }
                    .transition(.opacity)
                } else {
                    Text("No Bookmarks 🤷🏼‍♂️")
                        .transition(.opacity)
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView().environmentObject(ViewRouter())
    }
}

struct Number: View {
    var amount : Int
    
    var body: some View {
        Text("\(amount)")
            .font(.title)
            .bold()
    }
}

struct Caption: View {
    var text : String
    var body: some View {
        Text(text)
            .font(.caption)
            .foregroundColor(.secondary)
    }
}

struct FollowCount: View {
    var followers : Int
    var text : String
    
    var body: some View {
        VStack {
            Number(amount: followers)
            Caption(text : "Followers")
        }
    }
}

struct AvatarView: View {
    let imageSize = screen.width * 1/3 - 30
    
    var imageName : String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width : imageSize, height: imageSize)
            .cornerRadius(20)
            .shadow(color: Color.black, radius: 10, x: 0, y: 10)
    }
}

struct ButtonTitle: View {
    var text : String
    var textColor : Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 20, weight: .regular, design : .rounded))
            .frame(width : 130, height : 50)
            .foregroundColor(textColor)
    }
}

struct GridButtonContent: View {
    
    @Binding var photoGridIsActive : Bool
    
    var imageName : String
    
    var body: some View {
        ZStack {
            Rectangle()
                .stroke()
                .foregroundColor(.secondary)
            
            if imageName == "photo" {
                Image(systemName: photoGridIsActive ? "\(imageName).fill" : "\(imageName)")
                    .foregroundColor(photoGridIsActive ? .black : Color.black.opacity(0.6))
            } else {
                Image(systemName: photoGridIsActive ? "\(imageName)" : "\(imageName).fill")
                    .foregroundColor(photoGridIsActive ? Color.black.opacity(0.6) : .black )
            }
        }
    }
}

struct MyStaImage: View {
    
    var number : Int
    
    var body: some View {
        Image("insta\(number)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width : (screen.width / 3) - 10)
            .cornerRadius(20)
    }
}
