//
//  TabBarController.swift
//  businessApp
//
//  Created by Yue Fung Lee on 25/6/2021.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        view.backgroundColor = ColourConstants.baseColour
        customTabBar()
    }
    
    func customTabBar() {
        let appearance = tabBar.standardAppearance
        tabBar.backgroundColor = ColourConstants.baseColour
        tabBar.barTintColor = ColourConstants.baseColour
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
        tabBar.layer.cornerRadius = 30
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        tabBar.layer.masksToBounds = true
        
        let homeView = UINavigationController(rootViewController: HomeView())
        let forumView = UINavigationController(rootViewController: ForumView())
        let exemplarView = UINavigationController(rootViewController: ExemplarView())
        let profileView = UINavigationController(rootViewController: ProfileView())
        
        setViewControllers([homeView, forumView, exemplarView, profileView], animated: false)
        
        guard let items = tabBar.items else {
            return
        }
        
        let icons = ["homeView", "forumView", "exemplarView", "profileView"]
        
        for x in 0..<items.count {
            items[x].image = UIImage(named: icons[x])
            items[x].title = nil
            items[x].imageInsets = UIEdgeInsets(top: 15.5, left: 0, bottom: -15.5, right: 0)
        }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        object_setClass(self.tabBar, customTabBarHeight.self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class customTabBarHeight: UITabBar {
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            var sizeThatFits = super.sizeThatFits(size)
            sizeThatFits.height = 100
            return sizeThatFits
        }
    }
    
}
