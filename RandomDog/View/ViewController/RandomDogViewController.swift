//
//  RandomDogViewController.swift
//  RandomDog
//
//  Created by Jithin on 14/01/22.
//

import UIKit

class RandomDogViewController: UIViewController {

    @IBOutlet weak var generateDog: UIButton!
    @IBOutlet weak var recentDogs: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        generateDog.layer.cornerRadius = 10
        recentDogs.layer.cornerRadius = 10
    }
    



}
