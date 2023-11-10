//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//  

import Foundation

enum Tab: String, CaseIterable, Identifiable {
    case tab1 = "1.circle"
    case tab2 = "2.circle"
    case tab3 = "3.circle"
    
    var id: String { rawValue }
    
    var name: String {
        switch self {
        case .tab1: "Tab 1"
        case .tab2: "Tab 2"
        case .tab3: "Tab 3"
        }
    }
}
