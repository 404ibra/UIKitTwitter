//
//  FeedController.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import UIKit
import SDWebImage
import SnapKit

class FeedController: UIViewController {
    
    //MARK: - Life Cycles
    var user: UserModel? {
        didSet {
            configureNavbarLeadingItem()
        }
    }
    
    
    //MARK: - Life Cycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
    }
    
    
    
}

extension FeedController {
    private func configureUI() {
        view.backgroundColor = .white
        let imageView = UIImageView(image: UIImage(named: "twitter_logo_blue"))
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.width.equalTo(44)
        }
        navigationItem.titleView = imageView
        
        
    }
    
    func configureNavbarLeadingItem() {
        let profileImageView = UIImageView()
        profileImageView.backgroundColor = .twitterBlue
        profileImageView.snp.makeConstraints { make in
            make.height.equalTo(32)
            make.width.equalTo(32)
        }
        profileImageView.layer.masksToBounds = true
        guard let profileImageUrl = URL(string: user?.profileImageUrl ?? "") else { return }
        
        profileImageView.sd_setImage(with: profileImageUrl, completed: nil)
        profileImageView.layer.cornerRadius = 32 / 2
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: profileImageView)
    }
}
