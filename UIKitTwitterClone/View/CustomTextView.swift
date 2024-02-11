//
//  CustomTextView.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 11.02.2024.
//

import UIKit

class CaptionTextView: UITextView {
    
    //MARK: - Properties
    
    let placeholderLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = "What's happening?"
        return label
    }()
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Selectors
    
    @objc func handleTextInputChange() {
        placeholderLabel.isHidden = !text.isEmpty
    }
}

extension CaptionTextView {
    func configureUI() {
        backgroundColor = .white
        font = UIFont.systemFont(ofSize: 16)
        isScrollEnabled = false
        snp.makeConstraints { make in
            make.height.equalTo(300)
        }
        setupPlaceholderLabel()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleTextInputChange), name: UITextView.textDidChangeNotification, object: nil)
    }
    
    func setupPlaceholderLabel() {
        addSubview(placeholderLabel)
        placeholderLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(8)
            make.left.equalToSuperview().inset(4)
        }
    }
}
