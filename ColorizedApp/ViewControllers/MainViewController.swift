//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Иван Дрожжин on 13.07.2022.
//

import UIKit

protocol ColorSetupViewControllerDelegate {
    func saveColorSetup(with color: UIColor)
}

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let colorSetupVC = segue.destination as? ColorSetupViewController
        else { return }
        
        colorSetupVC.currentColor = view.backgroundColor
        colorSetupVC.delegate = self
    }
    

}

//MARK: ColorSetupViewControllerDelegate
extension MainViewController: ColorSetupViewControllerDelegate {
    func saveColorSetup(with color: UIColor) {
        view.backgroundColor = color
    }
}
