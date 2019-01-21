//
//  Model.swift
//  CurrencyCourses
//
//  Created by Aleksandr Avdukich on 21/01/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

/*
 <NumCode>036</NumCode>
 <CharCode>AUD</CharCode>
 <Nominal>1</Nominal>
 <Name>¿‚ÒÚ‡ÎËÈÒÍËÈ ‰ÓÎÎ‡</Name>
 <Value>16,0102
 */
class Currency {
  
  var NumCode: String?
  var CharCode: String?
  
  var NominalCode: String?
  var nominalDouble: Double?
  
  var Name: String?
  
  var Value: String?
  var valueDouble: Double?
}

class Model: NSObject {
  static let shared = Model()
  
  var currencies: [Currency] = []
  
  var pathForXML: String {
    //получить пусть для нашего XML
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
    //проверка на существование файла
    if FileManager.default.fileExists(atPath: path) {
      return path
    }
    //если файл не существует
    return Bundle.main.path(forResource: "data", ofType: "xml")!
  }
  
  var urlForXML: URL? {
    return nil
  }
  
  //загрузка XML с cbr.ru и сохранение его в каталоге приложения
  func loadXMLFile(data: Data) {
    
  }
 //проверяем есть ли у нас загруженный файл, если он есть то будем парсить загруженный, если нет то будем парсить по умолчанию data.xml
  //распарсить XML и положить его в currencies: [Currency], отправить уведомление приложению о том что его данные обновились
  func parseXML() {
    
  }
  
}
