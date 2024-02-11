//
//  TweetCell.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 11.02.2024.
//

import UIKit

class TweetCell: UICollectionViewCell {
    
    
    //MARK: - Properties
    
    var tweet: Tweet? {
        didSet { configure() }
    }

    private let profileImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .twitterBlue
        iv.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(48)
        }
        iv.layer.cornerRadius = 24
        return iv
    }()
    
    private let captionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.text = "Some test caption"
        return label
    }()
    
    private let infoLabel = UILabel()
    
    //Buttons
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        button.addTarget(self, action: #selector(handleCommentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retweetButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "retweet"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        button.addTarget(self, action: #selector(handleRetweetTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "like"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "share"), for: .normal)
        button.tintColor = .darkGray
        button.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        button.addTarget(self, action: #selector(handleShareTapped), for: .touchUpInside)
        return button
    }()

    
    //MARK: - Selectors
    @objc func handleCommentTapped() {
        
    }
    
    @objc func handleRetweetTapped() {
        
    }
    
    @objc func handlelikeTapped() {
        
    }
    
    @objc func handleShareTapped() {
        
    }
    
    
    
    //MARK: - Life Cycles

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupProfileImageView()
        
        let stack = UIStackView(arrangedSubviews: [infoLabel, captionLabel])
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.spacing = 4
        
        addSubview(stack)
        
        stack.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.top)
            make.left.equalTo(profileImageView.snp.right).inset(-12)
            make.right.equalToSuperview().inset(12)
        }
        
        infoLabel.textColor = .darkGray
        
        let underlineView = UIView()
        underlineView.backgroundColor = .systemGroupedBackground
        addSubview(underlineView)
        underlineView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(1)
        }
        
        infoLabel.font = UIFont.systemFont(ofSize: 14)
        
        let actionStack = UIStackView(arrangedSubviews: [commentButton, retweetButton, likeButton, shareButton])
        
        actionStack.axis = .horizontal
        actionStack.spacing = 72
        addSubview(actionStack)
        actionStack.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(8)
            make.centerX.equalToSuperview()
        }
      
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}

extension TweetCell {
    func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.left.equalToSuperview().inset(8)
        }
    }
}

extension TweetCell {
    func configure() {
        guard let tweet = tweet else { return }
        let viewModel = TweetViewModel(tweet: tweet)
        captionLabel.text = tweet.caption
       // guard let url = URL(string: tweet.user.profileImageUrl) else { return }
        profileImageView.sd_setImage(with: viewModel.profileImageUrl, completed: nil)
        infoLabel.attributedText = viewModel.userInfoText
    }
}
