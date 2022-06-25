//
//  ViewController.swift
//  ColorizedApp
//
//  Created by Иван Дрожжин on 24.06.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var colorRect: UIView!
    
    @IBOutlet weak var redColorIndexLabel: UILabel!
    @IBOutlet weak var greenColorIndexLabel: UILabel!
    @IBOutlet weak var blueColorIndexLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
   
    private var bgColor = UIColor(red: 200, green: 100, blue: 50, alpha: 1)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRect.layer.cornerRadius = 20
        colorRect.backgroundColor = bgColor
        //Не понимаю почему задаю цвет, а он затирает тот, что установлен в IB и тот, что устанавливаю я кодом и ставит все равно белый при загрузке приложения. Можете объяснить, что я тут сделал не так?
        
        setupColorSlider(for: redColorSlider)
        setupColorSlider(for: greenColorSlider)
        setupColorSlider(for: blueColorSlider)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        let currColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
        
        colorRect.backgroundColor = currColor
        
        switch sender {
            case redColorSlider:
                redColorIndexLabel.text = String(format: "%.2f", sender.value)
            case greenColorSlider:
                greenColorIndexLabel.text = String(format: "%.2f", sender.value)
            default:
                blueColorIndexLabel.text = String(format: "%.2f", sender.value)
        }
    }
    
    // MARK: private methods
    private func setupColorSlider(for slider: UISlider) {
        guard let colorComponents = bgColor.cgColor.components else { return }
        
        switch slider {
            case redColorSlider:
            slider.value = Float(colorComponents[0] / 255)
            redColorIndexLabel.text = String(format: "%.2f", colorComponents[0] / 255)
        case greenColorSlider:
            slider.value = Float(colorComponents[1] / 255)
            greenColorIndexLabel.text = String(format: "%.2f", colorComponents[1] / 255)
        default:
            slider.value = Float(colorComponents[2] / 255)
            blueColorIndexLabel.text = String(format: "%.2f", colorComponents[2] / 255)
        }
    }
    


}

