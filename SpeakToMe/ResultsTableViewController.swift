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
    
    var songName: String = ""
    var songArtist: String = ""
    var albumArt: String = ""
    private var data:[String] = []
    var count = 0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in 0...results.count - 1
        {
            getSongTitleAndArtistFromLastFM(rawSongName: getSongName(title: results[i]))
            //data.append("\(i)")
            data.append(songName);
        }
        print(data)
        tableView.dataSource = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //print(results)
        //print(getAlbumArt(songName: getSongName(title: results[0])))
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
        self.dismiss(animated: false, completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
        
//        if(count < results.count){
//        getSongTitleAndArtistFromLastFM(rawSongName: getSongName(title: results[count]))
//        }
//        count+=1;
//        print(count)
//
        
//        if albumArt.characters.count > 0 {
//            let url = URL(string: albumArt)
//            if let data = try? Data(contentsOf: url!){
//                cell.imageView?.image = UIImage(data: data)
//            }
//        } else {
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//            tableView.reloadData()
//        }
//
//        // Configure the cell...
        let text = data[indexPath.row]
        cell.textLabel?.text = songName
        cell.detailTextLabel?.text = songArtist
        //cell.textLabel?.text = text
        return cell
    }
    
    
    func getSongName(title: String) -> String{
        var songName = ""
        
        if title.contains(" - ") {
            songName = title.components(separatedBy: " - ")[1]
            if(songName.contains(" | ")){
                songName = songName.components(separatedBy: " | ")[0]
                
            }
            print("RAW SONG NAME****");
            print(songName + "\n")
     
        }
            
        else if title.contains(" – "){
            songName = title.components(separatedBy: " – ")[1]
            if(songName.contains(" | ")){
                songName = songName.components(separatedBy: " | ")[0]
            }
            print("RAW SONG NAME****");
            print(songName + "\n")
        }
        
        songName = songName.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
        
        return songName
    }
    
    
    
    
    func getSongTitleAndArtistFromLastFM(rawSongName: String){
        var input = rawSongName.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
        input = input.replacingOccurrences(of: "'", with: "%27", options: .literal, range: nil)
        
        print("INPUT INTO API****");
        print(input + "\n")
        
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
                        songName = (trackArray[0]["name"].string)!
                        print("SONG NAME RESULTING FROM API CALL****");
                        print(songName + "\n")
                        
                        songArtist = (trackArray[0]["artist"].string)!
                        print("SONG ARTIST RESULTING FROM API CALL****");
                        print(songArtist + "\n")
                        
                        albumArt = trackArray[0]["image"][0]["#text"].string!
                        print("SONG ALBUM ART URL RESULTING FROM API CALL****");
                        print(albumArt + "\n")
                    }
                }
            }
            
            
        }

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
