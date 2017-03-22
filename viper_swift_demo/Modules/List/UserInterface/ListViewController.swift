//
//  ListViewController.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import UIKit


/// ListView Interface API
protocol ListViewInterface: class {
    func show(noContentMessage title: String)
    func show(upcomingDispalyData data: UpcomingDisplayData)
    func reloadEntries()
}



fileprivate var ListEntryCellId = "ListEntryCell"

class ListViewController: UITableViewController {
        
    // MARK: - properties
    var eventHandler: ListModuleInterface?
    var dataProperty: UpcomingDisplayData?
    var strongTableView: UITableView?
    
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        strongTableView = self.tableView
        configureView()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.updateView()
    }
}

// MARK: - TableView dataSource
extension ListViewController {

    
    /// numberOfSections
    ///
    /// - Parameter tableView: UITableView
    /// - Returns: numberOfSections, Int
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let numberOfSections = dataProperty?.sections.count {
            return numberOfSections
        }
        return 0
    }
    
    
    /// numberOfRowsInSection
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section Int
    /// - Returns: numberOfRowsInSection, Int
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let upcomingSection = dataProperty?.sections[section].count {
            return upcomingSection
        }
        return 0
    }
    
    
    /// titleForHeaderInSection
    ///
    /// - Parameters:
    ///   - tableView: UITableView
    ///   - section: section Int
    /// - Returns: titleForHeaderInSection, String?
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let upcomingSectionTitle = dataProperty?.sections[section].name {
            return upcomingSectionTitle
        }
        return nil
    }
    
    
    /// reuse cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let upcomingSection = dataProperty?.sections[indexPath.section] {
            
            let upcomingItem = upcomingSection.items[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: ListEntryCellId, for: indexPath) as UITableViewCell
            cell.textLabel?.text = upcomingItem.title
            cell.detailTextLabel?.text = upcomingItem.dueDate
            cell.imageView?.image = UIImage(named: upcomingSection.imageName)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        return UITableViewCell()
    }
 
}

// MARK: - TableView delegate
extension ListViewController {
    
}

// MARK: - ListViewInterface
extension ListViewController: ListViewInterface {
    
    /// showNoConentMessage placeholder
    func show(noContentMessage title: String) {
        view = UIView()
    }
    
    /// show data
    func show(upcomingDispalyData data: UpcomingDisplayData) {
        view = strongTableView
        dataProperty = data
        reloadEntries()
    }
    
    /// reload tableView
    func reloadEntries() {
        tableView.reloadData()
    }

}



// MARK: - internal methods
extension ListViewController {
    
    /// configureView
    func configureView() {
        navigationItem.title = "VIPER TODO TEST"
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.rightBarButtonItem = addItem
    }
    
    /// handle TapAddButon
    @objc func didTapAddButton() {
        eventHandler?.addNewEntry()
    }
}







