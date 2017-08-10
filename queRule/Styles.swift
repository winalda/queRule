//
//  Styles.swift
//  queRule
//
//  Created by Erick on 10/08/17.
//  Copyright © 2017 Erick. All rights reserved.
//

import Foundation
import UIKit

func styleCell(view: UIView)
{
    view.layer.masksToBounds = false
    view.layer.shadowOffset = CGSize(width: 1, height: 1)
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowRadius = 2.0
    view.layer.shadowOpacity = 0.2
}
