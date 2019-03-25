//
//  MyNote.swift
//  Notes
//
//  Created by hackeru on 25/03/2019.
//  Copyright © 2019 lol. All rights reserved.
//

import UIKit

class MyNote {
    private var _description: String
    
    init(desc: String) {
        self._description = desc
    }
    
    public var desc: String{
        get{
            return _description
        }
        set{
            _description = newValue
        }
    }
    
    
    public var description: String{
        get{
            return "desc:\(self._description)"
        }
    }
    
}

