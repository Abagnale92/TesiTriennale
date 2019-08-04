//
//  BrowseViewController.swift
//  MicroApp
//
//  Created by Group1 on 05/07/17.
//  Copyright © 2017 Group1. All rights reserved.
//

import UIKit

class BrowseViewController: UITableViewController {
    
    var documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    var xmlFiles = [URL]()
    var directoryContents = [URL]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        // MicroAppEngine()
        var filePath = documentsUrl.appendingPathComponent("file1.xml")
        // file di deploy di esempio
        let text = "<xml>"
                + "<component id=\"1\" type=\"GENERICSTART\" state=\"VISIBLE\">"
                    + "<output id=\"2\" />"
                + "</component>"
                + "<component id=\"2\" type=\"GENERIC\" state=\"VISIBLE\">"
                    + "<input id=\"1\" dataname=\"string\" />"
                    + "<output id=\"3\" />"
                + "</component>"
                + "<component id=\"3\" type=\"GENERIC\" state=\"VISIBLE\">"
                    + "<input id=\"2\" dataname=\"string\" />"
                + "</component>"
            + "</xml>"
        do {
            try text.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            // error
        }
        filePath = documentsUrl.appendingPathComponent("file2.xml")
        do {
            try text.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            // error
        }
        filePath = documentsUrl.appendingPathComponent("file3.xml")
        do {
            try text.write(to: filePath, atomically: false, encoding: String.Encoding.utf8)
        } catch {
            // error
        }
        
        do {
            directoryContents = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil, options: [])
            xmlFiles = directoryContents.filter{ $0.pathExtension == "xml" }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        
        let insets = UIEdgeInsets(top: statusBarHeight, left:0, bottom: 0, right: 0)
        tableView.contentInset = insets
        tableView.scrollIndicatorInsets = insets
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return xmlFiles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UITableViewCell")

        // Configure the cell...
        cell.textLabel?.text = xmlFiles[indexPath.row].lastPathComponent
        return cell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            do {
                try FileManager.default.removeItem(at: self.xmlFiles[indexPath.row])
            }
            catch let error as NSError {
                print("Something went wrong: \(error)")
            }
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let filePath = xmlFiles[indexPath.row]
        let fileName = filePath.lastPathComponent
        let ac = UIAlertController (title: fileName, message: nil, preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        ac.addAction(cancelAction)
        
        let runAction = UIAlertAction(title: "Run", style: .default, handler: { (action)-> Void in
            let storyboard = UIStoryboard(name: "MicroApplication", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MicroApp") as! MicroAppViewController
            controller.filePath = filePath
            self.present(controller, animated: true, completion: nil)
        } )
        
        let deployAction = UIAlertAction(title: "Deploy", style: .default, handler: { (action)-> Void in print("Deploy") } )
        
        let editAction = UIAlertAction(title: "Edit", style: .default, handler: { (action)-> Void in print("Lavoro in corso") } )
        
        /* let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (action)-> Void in
            do {
                try FileManager.default.removeItem(at: self.xmlFiles[indexPath.row])
            }
            catch let error as NSError {
                print(error)
            }
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }) */
    
        ac.addAction(runAction)
        ac.addAction(deployAction)
        ac.addAction(editAction)
        // ac.addAction(deleteAction)
        present(ac, animated: true, completion: nil)
    }

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
