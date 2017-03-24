//
//  ListViewController.swift
//  viper_swift_demo
//
//  Created by PSL on 3/21/17.
//  Copyright © 2017 PSL. All rights reserved.
//

import UIKit


fileprivate let ListViewControllerNib = "ListViewController"
fileprivate var ListEntryCellId = "ListEntryCell"

class ListViewController: UITableViewController {
        
    // MARK: - properties owned
    var dataProperty: UpcomingDisplayData?
    var strongtableView: UITableView?
    var noContentView: UITableView?
    
    // MARK: - properties delegate
    var eventHandler: ListViewDelegate?
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        strongtableView = self.tableView
        self.tableView.register(UINib(nibName: ListEntryCellId, bundle: nil), forCellReuseIdentifier: ListEntryCellId)
        tableView.estimatedRowHeight = 20.0
        tableView.rowHeight = UITableViewAutomaticDimension
        configureView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventHandler?.updateView()
    }

    // MARK: - init
    init() {
        super.init(nibName: ListViewControllerNib, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    convenience init(title: String) {
        self.init()
        self.title = title
    }
}

// MARK: - TableView dataSource
extension ListViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let numberOfSections = dataProperty?.sections.count {
            return numberOfSections
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let upcomingSection = dataProperty?.sections[section].count {
            return upcomingSection
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    
        return self.dataProperty?.fetch(sectionTitle: section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let upcomingSection = dataProperty?.sections[indexPath.section],
            let cell = tableView.dequeueReusableCell(withIdentifier: ListEntryCellId, for: indexPath) as? ListEntryCell {
            
            let upcomingItem = upcomingSection.items[indexPath.row]
            cell.titleLabel?.text = upcomingItem.title
            cell.detailLabel?.text = upcomingItem.dueWeekday
            cell.dateLabel?.text = upcomingItem.dueDate
            //cell.imageView?.image = UIImage(named: upcomingSection.imageName)
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let dataProperty = dataProperty else { return }
        if editingStyle == .delete,
            let shouldRemove = dataProperty.fetch(item: indexPath) {
            let res = eventHandler?.removeEntry(shouldRemove)
            if res == true {
                _ = dataProperty.remove(item: indexPath)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                if dataProperty.isConentEmpty == true {
                    self.tableView.reloadData()
                }
                return
            }
        }
        print("List.VC: cannot remove cell in \(indexPath)")
    }
    
}

// MARK: - UITableViewDelegate
extension ListViewController {
    
}





// MARK: - ListViewInterface, Presenter's delegation
extension ListViewController: ListViewInterface {
    
    /// showNoConentMessage placeholder
    func show(noContentMessage title: String) {
        self.tableView = noContentView
    }
    
    /// show data
    func show(upcomingDispalyData data: UpcomingDisplayData) {
        self.tableView = strongtableView
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
        //self.view.backgroundColor = UIColor.lightGray
        navigationItem.title = "VIPER TODO TEST"
        let addItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(self.didTapAddButton))
        navigationItem.rightBarButtonItem = addItem
    }
    
    /// handle TapAddButon
    @objc func didTapAddButton() {
        eventHandler?.addNewEntry()
    }
}







