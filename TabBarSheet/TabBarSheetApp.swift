//
//  Created with ♥ by Serhii Pryimachuk on 10.11.2023.
//  

import SwiftUI

@main
struct TabBarSheetApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) private var appDelegate
    var windowSharedModel = WindowSharedModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(windowSharedModel)
        }
    }
}

/// App delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, 
                     configurationForConnecting connectingSceneSession: UISceneSession,
                     options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        let config = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        config.delegateClass = SceneDelegate.self
        return config
    }
}

// Scene Delegate
@Observable
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    weak var windowScene: UIWindowScene?
    var tabWindow: UIWindow?
    
    func scene(_ scene: UIScene, 
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        windowScene = scene as? UIWindowScene
    }
    
    /// Adding CustomTabBar as an another Window
    func addTabBar(_ windowSharedModel: WindowSharedModel) {
        guard let scene = windowScene else {
            return
        }
        
        let tabBarContoller = UIHostingController(
            rootView: CustomTabBar()
                .environment(windowSharedModel)
                .frame(maxHeight: .infinity, alignment: .bottom)
        )
        
        tabBarContoller.view.backgroundColor = .clear
        
        // Window
        let tabWindow = PassThroughWindow(windowScene: scene)
        tabWindow.rootViewController = tabBarContoller
        tabWindow.isHidden = false
        self.tabWindow = tabWindow
    }
}

/// PassThrough UIWindow
class PassThroughWindow: UIWindow {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if  let view = super.hitTest(point, with: event) {
            rootViewController?.view == view ? nil : view
        } else {
            nil
        }
    }
}
