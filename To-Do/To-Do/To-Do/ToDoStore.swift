//
//  ToDoStore.swift
//  To-Do
//
//  Created by Riley Osborne on 10/24/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class ToDoStore {
    static let shared = ToDoStore()
    
    var toDos: [[ToDo]]!
    
    var selectedImage: UIImage?
    
    init () {
        let filePath = archiveFilePath()
        let fileManger = FileManager.default
        
        if fileManger.fileExists(atPath: filePath) {
            toDos = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! [[ToDo]]
        }  else {
            toDos = [ ]
            for _ in 0...3 {
                toDos.append([])
            }
            toDos[0].append(ToDo(title: "Note 1", text: "Yo dawg", dueDate: Date()))
            save()
        }
       // sort()
    }
    
    //MARK: - Public functions
    
    func getToDo(_ sectionIndex: Int, _ rowIndex: Int) -> ToDo {
        return toDos[sectionIndex][rowIndex]
    }
    
    func addToDo (_ sectionIndex: Int, _ toDo: ToDo) {
        toDos[sectionIndex].insert(toDo, at: 0)
    }
    
    func updateToDo (_ toDo: ToDo, sectionIndex: Int, rowIndex: Int) {
        toDos[sectionIndex][rowIndex] = toDo
    }
    
    func deleteToDo(_ sectionIndex: Int, _ rowIndex: Int) {
        toDos[sectionIndex].remove(at: rowIndex)
    }
    
    func getCount(_ section: Int) -> Int {
        return toDos[section].count
    }
    
    func save() {
        NSKeyedArchiver.archiveRootObject(toDos, toFile: archiveFilePath())
    }
    
//    func sort() {
//        toDos.sort { (toDo1, toDo2) -> Bool in
//            return toDo1.date.compare(toDo2.date) == .orderedDescending
//        }
//    }
    
    // MARK: - Private Functions
    fileprivate func archiveFilePath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths.first!
        let path = (documentsDirectory as NSString).appendingPathComponent("ToDoStore.plist")
        return path
    }
}
