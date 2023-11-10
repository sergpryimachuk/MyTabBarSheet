//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//

import SwiftUI

extension View {
    /// Custom view modifier.
    @ViewBuilder
    func hideNativeTabBar() -> some View{
        self
            .toolbar(.hidden, for: .tabBar)
    }
}

extension TabView {
    /// Custom tabView modifier.
    @ViewBuilder
    func tabSheet<SheetContent: View>(initialHeight: CGFloat = 120,
                                      sheetCornerRadius: CGFloat = 15,
                                      @ViewBuilder content: @escaping () -> SheetContent) -> some View {
        self
            .modifier(BottomSheetModifier(initialHeight: initialHeight,
                                          sheetCornerRadius: sheetCornerRadius,
                                          sheetView: content()))
    }
}

fileprivate struct BottomSheetModifier<SheetContent: View>: ViewModifier {
    
    var initialHeight: CGFloat
    var sheetCornerRadius: CGFloat
    var sheetView: SheetContent
    
    @State private var isShowingSheet: Bool = true
    
    func body(content: Content) -> some View {
        VStack(spacing: 0) {
            sheetView
                .background(.regularMaterial)
                .zIndex(0)
            
            Divider()
                .hidden()
            
            Rectangle()
                .fill(.clear)
                .frame(height: 55)
        }
        .sheet(isPresented: $isShowingSheet) {
            sheetView
                .presentationDetents([.height(initialHeight), .medium, .fraction(0.999)])
                .presentationCornerRadius(sheetCornerRadius)
                .presentationBackgroundInteraction(.enabled(upThrough: .medium))
                .presentationBackground(.clear)
                .interactiveDismissDisabled()
        }
    }
}
