//
//  UIView.swift
//  JunGit
//
//  Created by 이창준 on 2022/10/24.
//

import UIKit

extension UIView {
    func loadFromXib() {
        let identifier = String(describing: type(of: self))
        let nibs = Bundle.main.loadNibNamed(identifier, owner: self)
        guard let view = nibs?.first as? UIView else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}
