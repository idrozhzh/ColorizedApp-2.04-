//
//  ColorSetupViewController.swift
//  ColorizedApp
//
//  Created by Иван Дрожжин on 24.06.2022.
//

import UIKit

class ColorSetupViewController: UIViewController {
    
    /*
     Осталось сделать
     1. Кнопка Done
     2. Подписать мэинВС под протокол для передачи данных
     3. Реализовать метод передачи данных
     4. Настроить клавиатуру для ТФ
     5. Добавить кнопку Done клавиатуре
     6. Настроить сворачивание клавиатуры
     7. Переписать функцию с текстовых полей по ТЗ
     8. Проверить работу приложения
     9. Почистить код
     
     */

    @IBOutlet weak var colorRectView: UIView!
    
    @IBOutlet weak var redColorIndexLabel: UILabel!
    @IBOutlet weak var greenColorIndexLabel: UILabel!
    @IBOutlet weak var blueColorIndexLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redColorTF: UITextField!
    @IBOutlet weak var greenColorTF: UITextField!
    @IBOutlet weak var blueColorTF: UITextField!
    
    
    var currentColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRectView.layer.cornerRadius = 20
        
        colorRectView.backgroundColor = currentColor
        viewSetup()
    }
    
    @IBAction func sliderAction() {
        colorRectView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1
        )
        
        sliderIndexLabelsSetup()
        sliderTextFieldsSetup()
        
        currentColor = colorRectView.backgroundColor
    }

    @IBAction func textFieldAction(_ sender: UITextField) {
        guard let textFieldValue = sender.text else { return }
        guard let floatTFValue = Float(textFieldValue) else { return }
        
        switch sender {
        case redColorTF:
            redColorSlider.value = floatTFValue
        case greenColorTF:
            greenColorSlider.value = floatTFValue
        default:
            blueColorSlider.value = floatTFValue
        }
        
        sliderAction()
    }
}

//MARK: private methods
extension ColorSetupViewController {
    
    private func sliderIndexLabelsSetup() {
        redColorIndexLabel.text = String(format: "%.2f", redColorSlider.value)
        greenColorIndexLabel.text = String(format: "%.2f", greenColorSlider.value)
        blueColorIndexLabel.text = String(format: "%.2f", blueColorSlider.value)
    }
    
    private func sliderTextFieldsSetup() {
        redColorTF.text = String(format: "%.2f", redColorSlider.value)
        greenColorTF.text = String(format: "%.2f", greenColorSlider.value)
        blueColorTF.text = String(format: "%.2f", blueColorSlider.value)
    }
    
    private func sliderViewSetup() {
        guard
            let colorComponents = currentColor.cgColor.components
        else { return }
        
        var count = 0
        for slider in [redColorSlider, greenColorSlider, blueColorSlider] {
            slider?.value = Float(colorComponents[count])
            count += 1
        }
    }
    
    private func viewSetup() {
        sliderViewSetup()
        sliderIndexLabelsSetup()
        sliderTextFieldsSetup()
    }
}
