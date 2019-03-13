//
//  ImageHelper.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/7/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

extension UIImageView {

    convenience init(named name: String) {
        self.init(image: UIImage(named: name))
        
        isUserInteractionEnabled = true
    }
}
