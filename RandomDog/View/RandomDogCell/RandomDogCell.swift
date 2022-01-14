//
//  RandomDogCell.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class RandomDogCell: UICollectionViewCell {
    @IBOutlet weak var dogImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()


    }
    func setImage(image:UIImage) {
        dogImageView.clipsToBounds = true
        //dogImageView.contentMode = .scaleToFill
        dogImageView.image = image
    }

}
