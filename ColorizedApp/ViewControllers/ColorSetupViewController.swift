//
//  ColorSetupViewController.swift
//  ColorizedApp
//
//  Created by Иван Дрожжин on 24.06.2022.
//

import UIKit

class ColorSetupViewController: UIViewController {

    @IBOutlet weak var colorRectView: UIView!
    
    @IBOutlet weak var redColorIndexLabel: UILabel!
    @IBOutlet weak var greenColorIndexLabel: UILabel!
    @IBOutlet weak var blueColorIndexLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRectView.layer.cornerRadius = 20
        
        sliderAction()
    }
    
    @IBAction func sliderAction() {
        colorRectView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
        
        sliderIndexLabelsSetup()
    }
    
    private func sliderIndexLabelsSetup() {
        redColorIndexLabel.text = String(format: "%.2f", redColorSlider.value)
        greenColorIndexLabel.text = String(format: "%.2f", greenColorSlider.value)
        blueColorIndexLabel.text = String(format: "%.2f", blueColorSlider.value)
    }
    


}

