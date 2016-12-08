//
//  ElementsTableViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marcel Chaucer on 12/8/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class ElementsTableViewController: UITableViewController {
    var theElements = [Element]()
    var apiEndPoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/elements"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.title = "Elements"
    }
    
    func loadData() {
        APIRequestManager.manager.getData(endPoint: apiEndPoint) { (elements: Data?) in
            if let validData = elements,
                let validElements = Element.getElements(from: validData) {
                DispatchQueue.main.async {
                    self.theElements = validElements
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return theElements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "elementCell", for: indexPath)
        let element = theElements[indexPath.row]
        
        cell.textLabel?.text = element.name
        cell.detailTextLabel?.text = "\(element.symbol)(\(element.number)) \(String(element.weight))"
        let thumbNailEndpoint = "https://s3.amazonaws.com/ac3.2-elements/\(element.symbol)_200.png"
        APIRequestManager.manager.getData(endPoint: thumbNailEndpoint) { (data: Data?) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    cell.imageView?.image = validImage
                    cell.setNeedsLayout()
                }
            }
        }
        return cell
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let avc = segue.destination as? DetailViewController,
            let cell = sender as? UITableViewCell,
            let indexPath = tableView.indexPath(for: cell) {
            avc.anElement = theElements[indexPath.row]
        }
    }
}
