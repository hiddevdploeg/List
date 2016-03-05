//
//  ViewController.swift
//  Minimalist 2
//
//  Created by Hidde van der Ploeg on 04/03/16.
//  Copyright © 2016 Hidde van der Ploeg. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet var addItem: UITextField!
    @IBOutlet var ListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ListTableView.dataSource = self
        ListTableView.delegate = self
        let padding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: 20))
        addItem.leftView = padding
        addItem.leftViewMode = UITextFieldViewMode.Always
        addItem.placeholder = "Add to list"
        addItem.delegate = self
        addItem.layer.cornerRadius = 4
        addItem.enablesReturnKeyAutomatically = true
        addItem.clearButtonMode = UITextFieldViewMode.WhileEditing
        addItem.returnKeyType = UIReturnKeyType.Done
        addItem.backgroundColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1)
        addItem.layer.borderColor = UIColor(red:0.98, green:0.98, blue:0.98, alpha:1).CGColor
        addItem.layer.borderWidth = 1
    }

    
    // MARK: Table
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("listCell", forIndexPath: indexPath)
        return cell
    }
    
}

