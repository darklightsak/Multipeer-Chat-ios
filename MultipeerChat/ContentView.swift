//
//  ContentView.swift
//  MultipeerChat
//
//  Created by darklightsak_office on 20/1/2564 BE.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NavigationView {
                ChatSessionView()
            }
            .navigationViewStyle(StackNavigationViewStyle())
            .tabItem {
                Image(systemName: "bubble.left")
                Text("Messages")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
