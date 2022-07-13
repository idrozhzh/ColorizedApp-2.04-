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
    
    @IBOutlet weak var redColorTF: UITextField!
    @IBOutlet weak var greenColorTF: UITextField!
    @IBOutlet weak var blueColorTF: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    
    var currentColor: UIColor!
    var delegate: ColorSetupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRectView.layer.cornerRadius = 20
        colorRectView.backgroundColor = currentColor
        viewSetup()
        
        doneButton.layer.cornerRadius = 10
        
        addToolbar()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
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
    
    @IBAction func doneButtonAction() {
        delegate.saveColorSetup(with: currentColor)
        dismiss(animated: true)
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

//MARK: UITextFieldDelegate
extension ColorSetupViewController: UITextFieldDelegate {
    private func addToolbar() {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace,
                                            target: self,
                                            action: nil
        )
        let doneButton = UIBarButtonItem(title: "Done",
                                         style: .done,
                                         target: self,
                                         action: #selector(toolbarDonePressed)
        )
        toolBar.items = [flexibleSpace, doneButton]
        toolBar.sizeToFit()
        
        redColorTF.inputAccessoryView = toolBar
        greenColorTF.inputAccessoryView = toolBar
        blueColorTF.inputAccessoryView = toolBar
        
        redColorTF.delegate = self
        greenColorTF.delegate = self
        blueColorTF.delegate = self
    }
    
    @objc private func toolbarDonePressed() {
        view.endEditing(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldValue = textField.text else { return }
        guard let floatTFValue = Float(textFieldValue) else { return }
        
        switch textField {
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
