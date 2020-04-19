//
//  PhotoModel.swift
//  jsonplaceholder-demo
//
//  Created by Mack Liu on 2020/4/5.
//  Copyright © 2020 Infinity-Bits Studio. All rights reserved.
//

import UIKit

struct PhotoModel: Decodable {
    
    var albumId: Int
    var id: Int
    var title: String
    var url: String
    var thumbnailUrl: String
}
