//
//  ResultsTableViewController.swift
//  SpeakToMe
//
//  Created by Rohan Katakam on 7/21/18.
//  Copyright © 2018 Henry Mason. All rights reserved.
//

import UIKit

class ResultsTableViewController: UITableViewController {
    
    var results : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print(results)
        print(getAlbumArt(songName: getSongName(title: results[0])))
        tableView.reloadData()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
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
        return results.count
    }
    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        var songName = getSongTitle(songName: getSongName(title: results[indexPath.row]))
        var songArtist = getArtistName(title: songName)
        var albumArt = getAlbumArt(songName: songName)
        cell.textLabel?.text = songName
        cell.detailTextLabel?.text = songArtist
        if albumArt.characters.count > 0 {
            let url = URL(string: albumArt)
            if let data = try? Data(contentsOf: url!){
                cell.imageView?.image = UIImage(data: data)
            }
        } else {
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
        
        
        
        
        // Configure the cell...
        
        return cell
    }
    
    
    func getSongName(title: String) -> String{
        var songName = ""
        
        if title.range(of:" - ") != nil {
            songName = title.components(separatedBy: " - ")[1]
        }
        songName = songName.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
        
        return songName
    }
    
    func getArtistName(title: String) -> String{
        var artistName = ""
        
        if title.range(of:" - ") != nil {
            artistName = title.components(separatedBy: " - ")[0]
        }
        
        return artistName
    }
    
    func getAlbumArt(songName: String) -> String {
        var input = songName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        input = input.replacingOccurrences(of: "'", with: "%27", options: .literal, range: nil)
        
        var out = ""
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=\(input)&api_key=6fc85a712cfd1d9d07dda99aadc05d08&format=json"
        // If statements checks to see if the URL is valid
        
        
        if let url = URL(string: urlString)
        {
            // Returns data objects and checks for errors
            if let myData = try? Data(contentsOf: url, options: [])
            {
                let json = JSON(myData)
                if let trackArray = json["results"][ "trackmatches"]["track"].array {
                    if trackArray.count > 0 {
                        out = trackArray[0]["image"][0]["#text"].string!
                    }
                }
            }
        }
        return out
    }
    
    func getSongTitle(songName: String) -> String{
        var input = songName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        input = input.replacingOccurrences(of: "'", with: "%27", options: .literal, range: nil)
        
        var out = ""

        let urlString = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=\(input)&api_key=6fc85a712cfd1d9d07dda99aadc05d08&format=json"
        // If statements checks to see if the URL is valid
        
        
        if let url = URL(string: urlString)
        {
            // Returns data objects and checks for errors
            if let myData = try? Data(contentsOf: url, options: [])
            {
                let json = JSON(myData)
                if let trackArray = json["results"][ "trackmatches"]["track"].array {
                    if(trackArray.count > 0) {
                        out = (trackArray[0]["name"].string)!
                    }
                }
            }
            
            
        }
        return out
    }
    
    func getSongArtist(songName: String) -> String{
        var input = songName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        input = input.replacingOccurrences(of: "'", with: "%27", options: .literal, range: nil)
        
        var out = ""
        
        let urlString = "http://ws.audioscrobbler.com/2.0/?method=track.search&track=\(input)&api_key=6fc85a712cfd1d9d07dda99aadc05d08&format=json"
        // If statements checks to see if the URL is valid
        
        
        if let url = URL(string: urlString)
        {
            // Returns data objects and checks for errors
            if let myData = try? Data(contentsOf: url, options: [])
            {
                let json = JSON(myData)
                if let trackArray = json["results"][ "trackmatches"]["track"].array {
                    if trackArray.count > 0 {
                        out = (trackArray[0]["artist"].string)!
                    }
                }
            }
            
            
        }
        return out
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
