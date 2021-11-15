//
//  HomeViewController.swift
//  NIBMParking
//
//  Created by Chathurika Bandara on 11/16/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var slotCollectionView: UICollectionView!
 
    let slotArray : [String] = ["Slot 01", "Slot 02", "Slot 03", "Slot 04", "Slot 05", "Slot 06", "Slot 07", "Slot 08", "Slot 09", "Slot 10", "Slot 11", "Slot 12", "Slot 13", "Slot 14", "Slot 15", "Slot 16", "Slot 17", "Slot 18", "Slot 19", "Slot 20"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        slotCollectionView.register(UINib(nibName: "SlotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SlotCollectionViewCell")
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = slotCollectionView.dequeueReusableCell(withReuseIdentifier: "SlotCollectionViewCell", for: indexPath) as! SlotCollectionViewCell
        let slot = slotArray[indexPath.row]
        cell.slotLabel.text = slot
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:  UICollectionViewLayout, sizeForItemAt indexPath:    IndexPath) -> CGSize {
        let size = CGSize(width: (self.slotCollectionView.frame.size.width - 30) / 4 ,height: (self.slotCollectionView.frame.size.height - 100) / 5)
        return size
    }
}
