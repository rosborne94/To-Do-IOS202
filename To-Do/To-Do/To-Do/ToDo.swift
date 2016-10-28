//
//  ToDo.swift
//  To-Do
//
//  Created by Riley Osborne on 10/24/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class ToDo: NSObject, NSCoding {
    var title = ""
    var text = ""
    var date = Date()
    var image: UIImage?
    var dueDate = Date()
    var category = 1
    var name = ""
    
    let titleKey = "title"
    let textKey  = "text"
    let dateKey = "date"
    let imageKey = "image"
    let dueDateKey = "dueDate"
    
    var dateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MM/dd/yyyy"
        return dateFormatter.string(from: dueDate)
    }
    var modifiedDateString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E MM/dd/yyyy"
        return dateFormatter.string(from: date)
    }
    
    override init( ) {
        super.init()
    }
    
    init(title: String, text: String, dueDate: Date) {
        self.title = title
        self.text = text
        self.dueDate = dueDate
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.title = aDecoder.decodeObject(forKey: titleKey) as! String
        self.text = aDecoder.decodeObject(forKey: textKey) as! String
        self.date = aDecoder.decodeObject(forKey: dateKey) as! Date
        self.image = aDecoder.decodeObject(forKey: imageKey) as? UIImage
        self.dueDate = aDecoder.decodeObject(forKey: dueDateKey) as! Date
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: titleKey)
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(date, forKey: dateKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(dueDate, forKey: dueDateKey)
    }
}
