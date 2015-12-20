//
//  DiaryLayout.swift
//  Note
//
//  Created by 安正超 on 15/10/23.
//  Copyright © 2015年 overtrue. All rights reserved.
//

import UIKit

class DiaryLayout: UICollectionViewFlowLayout {
    
    override func prepareLayout() {
        super.prepareLayout()
        let itemSize = CGSizeMake(itemWidth,itemHeight)
        self.itemSize = itemSize
        self.minimumInteritemSpacing = 0.0
        self.minimumLineSpacing = 0
    }
}
