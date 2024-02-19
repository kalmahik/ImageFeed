//
//  TabBarViewController.swift
//  ImageFeed
//
//  Created by Murad Azimov on 18.02.2024.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    override public func viewDidLoad() {
        setupViewControllers()
        self.delegate = self
    }
    
    func setupViewControllers() {
        let feedVC = ImagesListViewController()
        let profileVC = ProfileViewController()

        feedVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "rectangle.stack.fill"),
            selectedImage: UIImage(systemName: "rectangle.stack.fill")
        )
        
        profileVC.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(systemName: "person.crop.circle.fill"),
            selectedImage: UIImage(systemName: "person.crop.circle.fill")
        )
        
        tabBar.tintColor = .ypWhite
        tabBar.barTintColor = .ypBlack
        tabBar.backgroundColor = .ypBlack
        feedVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        viewControllers = [feedVC, profileVC]

        if #available(iOS 15, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .ypBlack
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        }
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {}
}
