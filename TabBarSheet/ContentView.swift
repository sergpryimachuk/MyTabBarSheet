//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(WindowSharedModel.self) private var windowSharedModel
    @Environment(SceneDelegate.self) private var sceneDelegate
    
    var body: some View {
        @Bindable var model = windowSharedModel
        TabView(selection: $model.selectedTab) {
            ForEach(Tab.allCases) { tab in
                NavigationStack {
                    Text(tab.name)
                        .navigationTitle(tab.name)
                }
                .tabItem {
                    Label(tab.name, systemImage: tab.rawValue)
                }
                .hideNativeTabBar()
            }
        }
        .tabSheet {
            NavigationStack {
                ScrollView {
                   // Your content
                }
            }
        }
        .onAppear {
            guard sceneDelegate.tabWindow == nil else {
                return
            }
            
            sceneDelegate.addTabBar(windowSharedModel)
        }
    }
}

#Preview {
    ContentView()
}
