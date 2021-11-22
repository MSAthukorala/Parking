//
//  SlotCollectionViewCell.swift
//  NIBMParking
//
//  Created by Chathurika Bandara on 11/16/21.
//

import UIKit

class SlotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var slotLabel: UILabel!
    @IBOutlet weak var bgView: UIView!


    override var isSelected: Bool {
        didSet {
            if isSelected{
                bgView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            } else {
                bgView.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
            }
        }
    }
    
}
