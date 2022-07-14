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
    
    var currentColor: CIColor!
    var delegate: ColorSetupViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorRectView.layer.cornerRadius = 20
        colorRectView.backgroundColor = UIColor(ciColor: currentColor)
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
        
        guard let color = colorRectView.backgroundColor else { return }
        currentColor = CIColor(color: color)
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
        redColorSlider.setValue(
            Float(currentColor.red),
            animated: false
        )
        greenColorSlider.setValue(
            Float(currentColor.green),
            animated: false
        )
        blueColorSlider.setValue(
            Float(currentColor.blue),
            animated: false
        )
    }
    
    private func viewSetup() {
        sliderViewSetup()
        sliderIndexLabelsSetup()
        sliderTextFieldsSetup()
    }
    
    private func showAlert(textField: UITextField) {
        let alert = UIAlertController(
            title: "Ошибка",
            message: "Введите число в диапазоне от 0 до 1",
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: { _ in
            switch textField {
            case self.redColorTF:
                textField.text = String(format: "%.2f", self.redColorSlider.value)
            case self.greenColorTF:
                textField.text = String(format: "%.2f", self.greenColorSlider.value)
            default:
                textField.text = String(format: "%.2f", self.blueColorSlider.value)
            }
        })
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
    @objc private func toolbarDonePressed() {
        view.endEditing(true)
    }
   
}

//MARK: UITextFieldDelegate
extension ColorSetupViewController: UITextFieldDelegate {
    private func addToolbar() {
        let toolBar = UIToolbar()
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil
        )
        let doneButton = UIBarButtonItem(
            title: "Done",
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

    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textFieldValue = textField.text else { return showAlert(textField: textField) }
        guard let floatTFValue = Float(textFieldValue) else { return showAlert(textField: textField) }
        
        switch textField {
        case redColorTF:
            redColorSlider.setValue(floatTFValue, animated: true)
        case greenColorTF:
            greenColorSlider.setValue(floatTFValue, animated: true)
        default:
            blueColorSlider.setValue(floatTFValue, animated: true)
        }
        
        sliderAction()
    }

}
