//
//  AddViewController.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import UIKit


protocol AddViewInterface {
    func setEntry(name: String)
    func setEntry(dueDate date: Date)
    func set(minDueDate date: Date)
}


class AddViewController: UIViewController {

    // MARK: - properties
    weak var eventHandler: AddModuleInterface?
    
    var minDate = Date()
    var transitioningBackgroundView = UIView()
    
    // MARK: - View
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var datePicker: UIDatePicker?
    
    // MARK: - Target action
    @IBAction func save(sender: Any) {
        if let name = nameTextField?.text,
            let dueDate = datePicker?.date {
            
            eventHandler?.saveAddAction(name: name, dueDate: dueDate)
        }
    }
    
    @IBAction func cancel(sender: Any) {
        nameTextField?.resignFirstResponder()
        eventHandler?.cancelAddAction()
    }
}


// MARK: - AddModuleEventDelegate 
extension AddViewController {
    @objc func dismissSelf() {
        eventHandler?.cancelAddAction()
    }
}


// MARK: - life cycle
extension AddViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let gestureRecognizer = UITapGestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(self.dismissSelf))
        
        transitioningBackgroundView.isUserInteractionEnabled = true
        
        nameTextField?.becomeFirstResponder()
        
        if let validDatePicker = datePicker {
            validDatePicker.minimumDate = minDate
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        nameTextField?.resignFirstResponder()
    }
}


// MARK: - AddViewInterface
extension AddViewController: AddViewInterface {
    func setEntry(name: String) {
        nameTextField?.text = name
    }
    
    func setEntry(dueDate date: Date) {
        if let validDatePicker = datePicker {
            validDatePicker.minimumDate = date
        }
    }
    
    func set(minDueDate date: Date) {
        minDate = date
        if let validDatePicker = datePicker {
            validDatePicker.minimumDate = date
        }
    }
}


// MARK: - UITextFieldDelegate
extension AddViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}





