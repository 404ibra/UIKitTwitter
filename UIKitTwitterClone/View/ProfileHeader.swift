//
//  ProfileHeader.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 12.02.2024.
//

import UIKit
import SnapKit

protocol ProfileHeaderDelegate: AnyObject {
    func handleDismissal()
}

class ProfileHeader: UICollectionReusableView {
    
    //MARK: - Properties
    
    var user: UserModel? {
        didSet {
            print("DEBUG: User has been setting in profile header")
            configure()
        }
    }
    
    weak var delegate: (ProfileHeaderDelegate)?
    
    private let filterBar = ProfileFilterView()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .twitterBlue
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(42)
            make.left.equalToSuperview().inset(16)
        }
        
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "baseline_arrow_back_white_24dp")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleDismissal), for: .touchUpInside)
        return button
    }()
    
    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.backgroundColor = .lightGray
        iv.layer.borderColor = UIColor.white.cgColor
        iv.layer.borderWidth = 4
        return iv
    }()
    
    private lazy var editProfileFollowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Loading", for: .normal)
        button.layer.borderColor = UIColor.twitterBlue.cgColor
        button.layer.borderWidth = 1.25
        button.setTitleColor(.twitterBlue, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleEditProfileFollow), for: .touchUpInside)
        return button
    }()
    
    private let bioLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 3
        label.text = "This is a user bio that will span more than one line for test purposes"
        return label
    }()
    
    private let fullnameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "Ibra aktas"
        return label
    }()
    
    private let usernameLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .lightGray
        label.text = "@404ibra"
        return label
    }()
    
    private let underlineView: UIView = {
       let view = UIView()
        view.backgroundColor = .twitterBlue
        return view
    }()
    
    private let followingLabel: UILabel = {
       let label =  UILabel()
        
        label.text = "0 Following"
        
        let followTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowingTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followTap)
        return label
    }()
    
    private let followersLabel: UILabel = {
       let label =  UILabel()
        
        label.text = "2 Followers"
        
        let followersTap = UITapGestureRecognizer(target: self, action: #selector(handleFollowersTapped))
        label.isUserInteractionEnabled = true
        label.addGestureRecognizer(followersTap)
        return label
    }()
    
    //MARK: - Selectors
    @objc func handleDismissal() {
        print("DEBUG: Handle dismiss")
    }
    
    @objc func handleEditProfileFollow() {
  
    }
    
    @objc func handleFollowersTapped() {
        
    }
    
    @objc func handleFollowingTapped() {
        
    }
    
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupContainerView()
        setupProfileImageView()
        setupEditProfileButton()
        setupFilterBar()
        setupUnderlineView()
        
        let userDetailsStack = UIStackView(arrangedSubviews: [fullnameLabel, usernameLabel, bioLabel])
        userDetailsStack.axis = .vertical
        userDetailsStack.distribution = .fillProportionally
        userDetailsStack.spacing = 4
        addSubview(userDetailsStack)
        
        userDetailsStack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(12)
            make.right.equalToSuperview().inset(12)
        }
        
        filterBar.delegate = self
        
        let followStack = UIStackView(arrangedSubviews: [followingLabel, followersLabel])
        followStack.axis = .horizontal
        followStack.spacing = 8
        followStack.distribution = .fillEqually
        
        addSubview(followStack)
        
        followStack.snp.makeConstraints { make in
            make.top.equalTo(userDetailsStack.snp.bottom).offset(8)
            make.left.equalToSuperview().inset(12)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileHeader {
    func setupContainerView() {
        addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(-24)
            make.left.equalToSuperview().inset(8)
            make.height.equalTo(80)
            make.width.equalTo(80)
        }
        profileImageView.layer.cornerRadius = 80 / 2
    }
    
    private func setupEditProfileButton() {
        addSubview(editProfileFollowButton)
        editProfileFollowButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.bottom).offset(12)
            make.right.equalToSuperview().inset(12)
            make.width.equalTo(100)
            make.height.equalTo(36)
        }
        editProfileFollowButton.layer.cornerRadius = 18
    }
}

//MARK: Setup profile header
extension ProfileHeader {
    func setupFilterBar() {
        addSubview(filterBar)
        filterBar.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    func setupUnderlineView() {
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.bottom.equalToSuperview()
            make.width.equalTo(frame.width / 3)
            make.height.equalTo(2)
        }
    }
}

extension ProfileHeader: ProfileFilterViewDelegate {
    func filterView(_ view: ProfileFilterView, didSelect indexPath: IndexPath) {
        guard let cell = view.collectionView.cellForItem(at: indexPath) as? ProfileFilterCell else { return }
        
        let xPosition = cell.frame.origin.x
        UIView.animate(withDuration: 0.3) {
            self.underlineView.frame.origin.x = xPosition
        }
    }
}

//MARK: - Helpers
extension ProfileHeader {
    func configure() {
        guard let user = user else { return }
        let viewModel = ProfileHeaderViewModel(user: user)
        guard let url = URL(string: user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: url, completed: nil)
        
        editProfileFollowButton.setTitle(viewModel.actionButtonTitle, for: .normal)
        followingLabel.attributedText = viewModel.followingString
        followersLabel.attributedText = viewModel.followersString
    }
}
