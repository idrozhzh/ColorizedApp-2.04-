//
//  MainViewController.swift
//  ColorizedApp
//
//  Created by Иван Дрожжин on 13.07.2022.
//

import UIKit

protocol ColorSetupViewControllerDelegate {
    func saveColorSetup(with color: CIColor)
}

class MainViewController: UIViewController {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let colorSetupVC = segue.destination as? ColorSetupViewController
        else { return }
        
        guard let color = view.backgroundColor else { return }
        colorSetupVC.currentColor = CIColor(color: color)
        colorSetupVC.delegate = self
    }
}

//MARK: ColorSetupViewControllerDelegate
extension MainViewController: ColorSetupViewControllerDelegate {
    func saveColorSetup(with color: CIColor) {
        view.backgroundColor = UIColor(ciColor: color)
    }
}
