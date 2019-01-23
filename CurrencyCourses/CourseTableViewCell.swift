//
//  CourseTableViewCell.swift
//  CurrencyCourses
//
//  Created by Aleksandr Avdukich on 23/01/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class CourseTableViewCell: UITableViewCell {

  
  @IBOutlet weak var imageFlag: UIImageView!
  @IBOutlet weak var labelCurrencyName: UILabel!
  @IBOutlet weak var labelCourse: UILabel!
  
  func initCell(currency: Currency) {
    imageFlag.image = currency.imageFlag
    labelCurrencyName.text = currency.Name
    labelCourse.text = currency.Value
  }
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
