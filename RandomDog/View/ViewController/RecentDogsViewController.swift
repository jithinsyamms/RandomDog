//
//  RecentDogsViewController.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class RecentDogsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var clearDogs: UIButton!

    let cellIdentifier = "RandomDogCell"
    let footerIdentifier = "RandomDogFooter"

    var dogDataModel = RandomDogViewModel()
    var recentDogs: [UIImage] = []

    private let itemsPerRow: CGFloat = 1.2
    private let sectionInsets = UIEdgeInsets(
        top: 0.0,
        left: 8.0,
        bottom: 0.0,
        right: 8.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        clearDogs.layer.cornerRadius = 10
        collectionView.register(UINib(nibName: "RandomDogCell",
                                      bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        recentDogs = dogDataModel.getAllImages()
        disableClearButton()
    }

    func disableClearButton() {
        clearDogs.isEnabled = recentDogs.count > 0 ? true : false
        clearDogs.alpha = recentDogs.count > 0 ? 1 : 0.3
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        dogDataModel.clearAllDogs()
        recentDogs = dogDataModel.getAllImages()
        collectionView.reloadData()
        disableClearButton()
    }
}

extension RecentDogsViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recentDogs.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as? RandomDogCell {
            cell.setImage(image: recentDogs[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }

}

extension RecentDogsViewController: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {

        var totalSpace: CGFloat = 0
        if let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout {
            totalSpace = flowLayout.sectionInset.left
                + flowLayout.sectionInset.right
                + (flowLayout.minimumInteritemSpacing * CGFloat(itemsPerRow - 1))
        }
        let width = Int((collectionView.bounds.width - totalSpace) / CGFloat(itemsPerRow))
        let height = width
        return CGSize(width: width, height: height )
    }

    func collectionView( _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                         insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}
