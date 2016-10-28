//
//  ToDoDetailViewController.swift
//  ToDos
//
//  Created by Riley Osborne on 10/18/16.
//  Copyright © 2016 Riley Osborne. All rights reserved.
//

import UIKit

class ToDoDetailViewController: UIViewController {
    @IBOutlet weak var toDoTitleField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var toDoTextView: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var viewPicker: UIDatePicker!
    @IBOutlet weak var categoryPicker: UIPickerView!
    @IBOutlet weak var pickerLabel: UILabel!
    
    var gestureRecognizer: UITapGestureRecognizer!
    
    var toDo = ToDo()
    var categoryNames = ["Home", "Work", "Fitness", "Other"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toDoTitleField.text = toDo.title
        toDoTextView.text = toDo.text
        self.view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        if let image = toDo.image {
            imageView.image = image
            addGestureRecognizer()
        } else {
            imageView.isHidden =  true
        }
        self.categoryPicker.dataSource = self
        self.categoryPicker.delegate = self
    }
    
override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
}

func addGestureRecognizer() {
    gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewImage))
    imageView.addGestureRecognizer(gestureRecognizer)
}

func viewImage() {
    if let image = imageView.image {
        ToDoStore.shared.selectedImage = image
        let viewController = UIStoryboard(name: "Main", bundle: nil) .
            instantiateViewController(withIdentifier: "ImageNavController")
        present(viewController, animated: true, completion: nil)
    }
}

fileprivate func showPicker (_ type: UIImagePickerControllerSourceType) {
    let imagePicker = UIImagePickerController ()
    imagePicker.delegate =  self
    imagePicker.sourceType = type
    present(imagePicker, animated: true, completion: nil)
}




// MARK: - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    toDo.title = toDoTitleField.text!
    toDo.text = toDoTextView.text
    toDo.date = Date()
    toDo.image = imageView.image
    toDo.dueDate = datePicker.date
  
    let selectedCategory = categoryPicker.selectedRow(inComponent: 0)
    toDo.category = categoryPicker.selectedRow(inComponent: 0)
    
    switch selectedCategory {
    case 0:
        toDo.category = 0
    case 1:
        toDo.category = 1
    case 2:
        toDo.category = 2
    case 3:
        toDo.category = 3
    default :
        toDo.category = 0
    }
}

//MARK - IBActions
@IBAction func choosePhoto(_ sender: AnyObject) {
    let alert = UIAlertController(title: "Picture", message: "Choose a picture type", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in self.showPicker(.camera) } ))
    alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in self.showPicker(.photoLibrary) } ))
    present(alert, animated: true, completion: nil)
}
@IBAction func chooseDate(_ sender: AnyObject) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "E MM/dd/yyyy hh:mm a"
    let strDate = dateFormatter.string(from: datePicker.date)
    self.dueDateLabel.text = strDate
}
}

extension ToDoDetailViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerControllerDidCancel (_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            let maxSize: CGFloat = 512
            let scale = maxSize / image.size.width
            let newHeight = image.size.height * scale
            
            UIGraphicsBeginImageContext(CGSize(width: maxSize, height: newHeight))
            image.draw(in: CGRect(x: 0, y: 0, width: maxSize, height: newHeight))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            imageView.image = resizedImage
            
            imageView.isHidden = false
            if gestureRecognizer != nil {
                imageView.removeGestureRecognizer(gestureRecognizer)
            }
            addGestureRecognizer()
        }
    }
}
//MARK: - Picker Funcs
extension ToDoDetailViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoryNames.count;
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoryNames[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerLabel.text = categoryNames[row]
    }

}



