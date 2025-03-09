//
//  AlertViewController.swift
//  ToDoList
//
//  Created by Aya on 09/03/2025.
//

import Foundation
import CleanyModal

class MyAlertViewController: CleanyAlertViewController {
    init(title: String?, message: String?, imageName: String? = nil, preferredStyle: CleanyAlertViewController.Style = .alert) {
        let styleSettings = CleanyAlertConfig.getDefaultStyleSettings()
        styleSettings[.tintColor] = .yellow
        styleSettings[.destructiveColor] = .systemPink
        super.init(title: title, message: message, imageName: imageName, preferredStyle: preferredStyle, styleSettings: styleSettings)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
