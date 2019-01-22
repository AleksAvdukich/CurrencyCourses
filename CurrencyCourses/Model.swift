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
  
  var Nominal: String?
  var nominalDouble: Double?
  
  var Name: String?
  
  var Value: String?
  var valueDouble: Double?
}

class Model: NSObject, XMLParserDelegate {//идет по тегам последовательно в XML и когда встречает тот или иной тег он вызывает соответствующую функцию делегата
  static let shared = Model()
  
  var currencies: [Currency] = []
  var currentDate: String = ""//подгружаем данные за определенную дату
  
  var pathForXML: String {
    //получить путь для нашего XML
    let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"
    //проверка на существование файла
    if FileManager.default.fileExists(atPath: path) {
      return path
    }
    //если файл не существует
    return Bundle.main.path(forResource: "data", ofType: "xml")!
  }
  
  var urlForXML: URL {
    return URL(fileURLWithPath: pathForXML)
  }
  
  //загрузка XML с cbr.ru и сохранение его в каталоге приложения
  //http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
  func loadXMLFile(date: Date?) {
    
    var strUrl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req="
    
    if date != nil {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd/MM/yyyy"
      strUrl = strUrl + dateFormatter.string(from: date!)
    }
    
    let url = URL(string: strUrl)
    
    let task = URLSession.shared.dataTask(with: url!) { (data, responce, error) in
      if error == nil {//данные которые нам пришли нужно сохранить по пути
        let path =  NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml"//путь
        let urlForSave = URL(fileURLWithPath: path)
        
        do {
          try data?.write(to: urlForSave) //у write деректива throws => надо отследить ошибку
          print(path)
          print("Файл загружен")
          //после того как файл загрузился нам надо обновить данные
          self.parseXML() //перепарсиваем новый XML который загрузили
          
        } catch {
          print("Error with save data:\(error.localizedDescription)")
        }
        
      } else {
        print("Error when loadXMLFile:" + error!.localizedDescription)
      }
    }
    task.resume()
    
  }
  
  //проверяем есть ли у нас загруженный файл, если он есть то будем парсить загруженный, если нет то будем парсить по умолчанию data.xml
  //распарсить XML и положить его в currencies: [Currency], отправить уведомление приложению о том что его данные обновились
  func parseXML() {
    currencies = [] //перед тем как парсить обнуляем массив
    
    let parser = XMLParser(contentsOf: urlForXML)
    parser?.delegate = self
    parser?.parse()
    //после того как распарсили XML  оказываемся здесь
    print("Данные обновлены")
    //после этого мы должны обновить View, чтобы показать новые данные
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)//отправится уведомление по всему приложению
  }
  
  //как только он находит любой елемент он вызывает этот метод, в этом методе у нас все данные которые будут а аттрибутах XML у нас будут в словаре attributeDict
  
  var currentCurrency: Currency?
  
  func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
    if elementName == "ValCurs" {
      if let currentDateString = attributeDict["Date"] {//по ключу Date получили значение
        currentDate = currentDateString
      }
    }
    
    if elementName == "Valute" {
      currentCurrency = Currency()
    }
    
  }
  
  var currentCharacters: String = ""
  //когда находит какие либо символы то вызывается этот метод
  func parser(_ parser: XMLParser, foundCharacters string: String) {
    currentCharacters = string
  }
  
  //когда элемент закрывается вызывается этот метод
  func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
    
    if elementName == "NumCode" {
      currentCurrency?.NumCode = currentCharacters
    }
    
    if elementName == "CharCode" {
      currentCurrency?.CharCode = currentCharacters
    }
    
    if elementName == "Nominal" {
      currentCurrency?.Nominal = currentCharacters
      currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
    }
    
    if elementName == "Name" {
      currentCurrency?.Name = currentCharacters
    }
    
    if elementName == "Value" {
      currentCurrency?.Value = currentCharacters
      currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."))
    }
    
    
    if elementName == "Valute" {
      currencies.append(currentCurrency!)
    }
    
  }
  
}
