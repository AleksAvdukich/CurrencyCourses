//
//  ConvertViewController.swift
//  CurrencyCourses
//
//  Created by Aleksandr Avdukich on 23/01/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class ConverterViewController: UIViewController {
  
  @IBOutlet weak var labelCoursesForDate: UILabel!
  
  @IBOutlet weak var buttonFrom: UIButton!
  @IBOutlet weak var buttonTo: UIButton!
  
  @IBAction func pushFromAction(_ sender: Any) {
    let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
    (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .from
    present(nc, animated: true, completion: nil)
  }
  
  @IBAction func pushToAction(_ sender: Any) {
    let nc = storyboard?.instantiateViewController(withIdentifier: "selectedCurrencyNSID") as! UINavigationController
    (nc.viewControllers[0] as! SelectCurrencyController).flagCurrency = .to
    present(nc, animated: true, completion: nil)
  }
  
  @IBOutlet weak var textFrom: UITextField!
  @IBOutlet weak var textTo: UITextField!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    textFrom.delegate = self
  }
  //view начинает появляться
  override func viewWillAppear(_ animated: Bool) {
    refreshButtons()
    textFromEditingChange(self)
    labelCoursesForDate.text = "Курсы за дату: \(Model.shared.currentDate)"
    navigationItem.rightBarButtonItem = nil
  }
  
  
  @IBOutlet weak var buttonDone: UIBarButtonItem!
  @IBAction func pushDoneAction(_ sender: Any) {
    textFrom.resignFirstResponder()
    navigationItem.rightBarButtonItem = nil
  }
  
  
  @IBAction func textFromEditingChange(_ sender: Any) {
    
    let amount = Double(textFrom.text!)
    textTo.text = Model.shared.convert(amount: amount)
    
  }
  
  
  func refreshButtons() {
    buttonFrom.setTitle(Model.shared.fromCurrency?.CharCode, for: .normal)
    
    buttonTo.setTitle(Model.shared.toCurrency?.CharCode, for: .normal)
  }
  
}

extension ConverterViewController: UITextFieldDelegate {
  //когда начинается редактирование поля вызывается этот метод
  func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    navigationItem.rightBarButtonItem = buttonDone
    
    return true
  }
  
}
