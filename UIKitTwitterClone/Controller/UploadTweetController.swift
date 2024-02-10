//
//  UploadTweetController.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 10.02.2024.
//

import UIKit
import SnapKit
import SDWebImage

class UploadTweetController: UIViewController {
    
    //MARK: - Properties
    
    private let user: UserModel
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .twitterBlue
        button.setTitle("Tweet", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        button.frame = CGRect(x: 0, y: 0, width: 64, height: 32)
        button.layer.cornerRadius = 16
        
        button.addTarget(self, action: #selector(handleUploadTweet), for: .touchUpInside)
        
        return button
    }()
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .twitterBlue
        iv.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        iv.layer.cornerRadius = 24
        return iv
    }()
    
    //MARK: - Life Cycles
    init(user: UserModel) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureUI()
    }
    
    //MARK: - Selectors
    @objc func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUploadTweet() {
        
    }
}
//MARK: - Helpers
extension UploadTweetController {
    func configureUI() {
        view.backgroundColor = .white
        configureNavigationBar()
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.left.equalToSuperview().inset(16)
        }
        guard let profilePhotoURL = URL(string: user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: profilePhotoURL, completed: nil)
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.isTranslucent = false
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: actionButton)
    }
}
