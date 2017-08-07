//
//  Utils.swift
//  queRule
//
//  Created by Erick Alberto Morales Ledesma on 06/08/17.
//  Copyright © 2017 Erick. All rights reserved.
//

import Foundation

extension String
{
    //Regresa la posicion donde se encunetra el valor del caracter de que le asignemos 
    //a target
    func indexOf(target: String) -> Int?
    {
        if let range = self.range(of: target)
        {
            return distance(from: self.startIndex, to: range.lowerBound)
        }else{
            return nil
        }
    }
}
