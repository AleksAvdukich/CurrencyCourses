//
//  SettingsController.swift
//  CurrencyCourses
//
//  Created by Aleksandr Avdukich on 22/01/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class SettingsController: UIViewController {
  
  @IBOutlet weak var dataPicker: UIDatePicker!
  
  @IBAction func pushCancelAction(_ sender: Any) {
    dismiss(animated: true, completion: nil)
  }
  
  @IBAction func pushShowCourses(_ sender: Any) {
    //когда нажали показать курсы за дату, берем дату из пикера и вызываем loadXMLFile с этой датой которую выбрали
    Model.shared.loadXMLFile(date: dataPicker.date)
    dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}
