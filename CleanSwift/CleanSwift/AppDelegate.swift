//
//  AppDelegate.swift
//  CleanSwift
//
//  Created by Robertas Baronas on 07/08/2020.
//  Copyright © 2020 Robertas Baronas. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard
import RealmSwift

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    fileprivate var resolver: Resolver?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // TODO: remove later, it's just for development
        print("Realm location: ", Realm.Configuration.defaultConfiguration.fileURL!)
        
        resolver = DependencyContainer.registerAndRetrieveContainer().synchronize()
        setupFirstWindow()
        
        return true
    }
    
    private func setupFirstWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        guard let container = resolver else {
            fatalError("Container have to be present before initializing view")
        }
        
        let storyboard = SwinjectStoryboard.create(name: "Main",
                                                   bundle: Bundle.main,
                                                   container: container)
        let viewController = storyboard.instantiateInitialViewController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}
