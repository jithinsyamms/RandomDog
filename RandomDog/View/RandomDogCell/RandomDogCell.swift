//
//  RandomDogCell.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class RandomDogCell: UICollectionViewCell {
    @IBOutlet weak var dogImageView: UIImageView!
    @IBOutlet weak var width: NSLayoutConstraint!
    @IBOutlet weak var height: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    func setImage(image: UIImage) {
        dogImageView.image = image
        dogImageView.contentMode = .scaleAspectFit
    }

}
