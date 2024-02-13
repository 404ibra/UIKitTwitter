//
//  ProfileFilterCell.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 12.02.2024.
//

import UIKit

class ProfileFilterCell: UICollectionViewCell {
    //MARK: - Properties
    
    var option: ProfileFilterOptions! {
        didSet { titleLabel.text = option.description }
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "Test"
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected
                ? UIFont.boldSystemFont(ofSize: 16)
                : UIFont.systemFont(ofSize: 16)
            titleLabel.textColor = isSelected ? .twitterBlue : .lightGray
        }
    }
    
    //MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
