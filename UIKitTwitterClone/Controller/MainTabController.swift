//
//  MainTabController.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import UIKit
import SnapKit
import Firebase

class MainTabController: UITabBarController {
    
    //MARK: - Properties
    
    var user: UserModel? {
        didSet {
            guard let nav = viewControllers?[0] as? UINavigationController else { return }
            guard let feed = nav.viewControllers.first as? FeedController else { return }
            
            feed.user = user
        }
    }
    
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.backgroundColor = .twitterBlue
        button.setImage(UIImage(named: "new_tweet"), for: .normal)
        button.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        return button
    }()
    
    //MARK: - Selectors
    
    @objc func actionButtonTapped() {
        guard let user = user else { return }
        let controller = UploadTweetController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
    }
    
    //MARK: - Life Cycles

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        setupActionButton()
        authenticateUserAndConfigureUI()
       //logOut()
        
    }
    //MARK: - Helpers
    func configureViewControllers() {
        let feed = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let nav1 = templateNavigationController(image: UIImage(named: "home_unselected"), rootViewController: feed)
        
        let explore = ExploreController()
        let nav2 = templateNavigationController(image: UIImage(named: "search_unselected"), rootViewController: explore)
        
        let notifications = NotificationsController()
        let nav3 =  templateNavigationController(image: UIImage(named: "like_unselected"), rootViewController: notifications)
        
        
        let conversations = ConversationController()
        let nav4 =  templateNavigationController(image: UIImage(named: "ic_mail_outline_white_2x-1"), rootViewController: conversations)
        
        viewControllers = [nav1, nav2, nav3, nav4]
        tabBar.backgroundColor = .systemBackground
         
    }
    
    func templateNavigationController(image: UIImage?, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = image
 
        return nav
    }
}

extension MainTabController {
     func authenticateUserAndConfigureUI () {
        if Auth.auth().currentUser == nil {
            DispatchQueue.main.async {
                let nav = UINavigationController(rootViewController: LoginController())
                nav.modalPresentationStyle = .fullScreen
                self.present(nav, animated: true, completion: nil)
                
            }
        } else {
            print("buraya girdi mi configureui else blogu")
            setupActionButton()
           configureViewControllers()
            guard let uid = Auth.auth().currentUser?.uid else { return }
            UserService.shared.fetchUser(uid: uid) { user in
                self.user = user
            }
            
        }
    }
    
    private func logOut() {
        do {
            try Auth.auth().signOut()
        } catch let error {
            print("DEBUG: Failed when logged out \(error)")
        }
    }
    
    private func setupActionButton() {
        view.addSubview(actionButton)
        actionButton.layer.cornerRadius = 56/2
        actionButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(64)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(56)
            make.width.equalTo(56)
        }
    }
}
