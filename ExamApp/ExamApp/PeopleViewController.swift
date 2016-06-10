//
//  FirstViewController.swift
//  ExamApp
//
//  Created by Iman Zarrabian on 07/06/16.
//  Copyright © 2016 Web School Factory. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {

    var peoplesArray: [People] = []
    //computed properties
    var peoplesOffset: Int {
        return peoplesArray.count
    }
    
    @IBOutlet weak var peopleTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        peopleTV.estimatedRowHeight = 200.0
        peopleTV.rowHeight = UITableViewAutomaticDimension
        
        displayPeoples()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayPeoples() {
        //declencher un WS
        //START SPINNER
        NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
        
        People.getRemotePeoples(peoplesOffset) { (response) in
            
            switch response.result {
            case .Success:
                if let dict = response.result.value as? Dictionary<String, AnyObject> {
                    if let dataDict = dict["data"] {
                        
                        if let array = dataDict["results"] as? Array<AnyObject>  {
                            
                            self.peoplesArray += array.map
                                { People(dict: $0 as! [String: AnyObject]) }
                            
                            self.peopleTV.reloadData()
                            //STOP SPINNER
                            NSNotificationCenter.defaultCenter().postNotificationName("spinner_notif", object: nil)
                        }
                    }
                }
                
            case .Failure(let error):
                print(error)
            }
        }
    }
}

extension PeopleViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comicsArray.count + 1
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCellWithIdentifier("PeopleCell", forIndexPath: indexPath) as! PeopleCell
            let people = peoplesArray[indexPath.row]
            cell.NameLabel.text = people.name
            cell.HeightLabel.text = people.height
            cell.MassLabel.text = people.mass
            cell.SkinColorLabel.text = people.skin_color
        
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        if indexPath.row == comicsArray.count {
            displayComics()
        }
    }
    
    
    
}

