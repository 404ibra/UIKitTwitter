//
//  ConversationController.swift
//  UIKitTwitterClone
//
//  Created by İbrahim Aktaş on 9.02.2024.
//

import UIKit

class ConversationController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()

    }
    


}


extension ConversationController {
    private func configureUI() {
    
        view.backgroundColor = .white
        navigationItem.title = "Messages"
    }
}
