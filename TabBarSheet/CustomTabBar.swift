//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//  

import SwiftUI

struct CustomTabBar: View {
    
    @Environment(WindowSharedModel.self) private var windowSharedModel
    
    var body: some View {
        VStack(spacing: 0) {
            Divider()
            HStack(spacing: 0) {
                ForEach(Tab.allCases) { tab in
                    Button {
                        windowSharedModel.selectedTab = tab
                    } label: {
                        VStack {
                            Image(systemName: tab.rawValue)
                            Text(tab.name)
                        }
                        .foregroundStyle(windowSharedModel.selectedTab == tab
                                         ? Color.accentColor
                                         : .gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .contentShape(.rect)
                    }
                }
            }
            .frame(height: 55)
        }
        .background(.regularMaterial)
    }
}

#Preview {
    CustomTabBar()
        .environment(WindowSharedModel())
}
