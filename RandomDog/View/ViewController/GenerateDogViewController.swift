//
//  GenerateDogViewController.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class GenerateDogViewController: UIViewController {

    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var dogImage: UIImageView!
    private var dogViewModel = RandomDogViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        generateButton.layer.cornerRadius = 10
        dogViewModel.delegate = self

    }
    @IBAction func generateTapped(_ sender: Any) {
        dogViewModel.fetchRandomDog()
    }
}

extension GenerateDogViewController: RandomDogProtocol {
    func imageDownloaded(image: UIImage) {
        dogImage.image = image
    }
}
