//
//  AddViewController.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import UIKit





fileprivate let AddViewControllerNib = "AddViewController"

class AddViewController: UIViewController {

    // MARK: - properties owned
    var minDate = Date()
    var transitioningBackgroundView = UIView()
    
    // MARK: - delegate
    weak var eventHandler: AddViewToPresenterDelegate?
    
    // MARK: - View
    @IBOutlet weak var nameTextField: UITextField?
    @IBOutlet weak var datePicker: UIDatePicker?
    
    // MARK: - Target action
    @IBAction func save(sender: UIButton) {
        var name = "No name"
        if let validName = nameTextField?.text,
            validName.isEmpty == false {
            name = validName
        }
        let dueDate = datePicker?.date ?? Date()
        print("Save DueDate: \(dueDate)")
        
        eventHandler?.saveAddAction(name: name, dueDate: dueDate)
    }
    
    @IBAction func cancel(sender: UIButton) {
        nameTextField?.resignFirstResponder()
        eventHandler?.cancelAddAction()
    }
    
    
    // MARK: - init
    init() {
        super.init(nibName: AddViewControllerNib, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(title: String) {
        self.init()
        self.title = title
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
extension AddViewController: PresenterToAddViewDelegate {
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





