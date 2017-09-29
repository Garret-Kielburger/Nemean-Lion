//
//  NavigationDrawerTableViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-25.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class NavigationDrawerTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var screens = [ScreenDataObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Use the edit button item provided by the table view controller.
        navigationItem.leftBarButtonItem = editButtonItem
        
        // Load the screen names
        screens = NemeanDatabase.instance.getAllScreens()

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Table view data source
    
    // number of sections is like the Android equivalent
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return screens.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
//        // Table view cells are reused and should be dequeued using a cell identifier.
//        let cellIdentifier = "ScreenTableViewCell"
//        
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ScreenTableViewCell  else {
//            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
//        }
//        

        let cell: UITableViewCell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        // Fetches the appropriate meal for the data source layout.
        let screen = screens[indexPath.row]
        
        cell.textLabel!.text = screen.name
        //cell.photoImageView.image = screen.photo
        
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }
    */
    

    
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    //MARK: - Navigation
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(screens[indexPath.row].uuid)
        
        let rootViewController = NavDrawerRootViewController(screen_uuid: screens[indexPath.row].uuid)
        //self.navigationController?.pushViewController(mainViewController, animated: true)
        toolbarController?.transition(to: rootViewController, completion: closeNavigationDrawer)
        
    }
    
    fileprivate func closeNavigationDrawer(result: Bool) {
        navigationDrawerController?.closeLeftView()
    }

    

    //MARK: Private Methods
    


    
    
}
