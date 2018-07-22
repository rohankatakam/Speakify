//
//  SecondViewController.swift
//  SpeakToMe
//
//  Created by Rohan Katakam on 7/22/18.
//  Copyright © 2018 Henry Mason. All rights reserved.
//

import UIKit
import SwiftSoup

class SecondViewController: UIViewController {
  
    @IBOutlet weak var sorryButton: UILabel!
    @IBOutlet weak var wrongResultButton: UIButton!
    @IBOutlet weak var labelOne: UILabel!
    @IBOutlet weak var labelTwo: UILabel!
    @IBOutlet weak var labelThree: UILabel!
    @IBOutlet weak var labelFour: UILabel!
    @IBOutlet weak var labelFive: UILabel!
    
    @IBOutlet weak var imageOne: UIImageView!
    @IBOutlet weak var imageTwo: UIImageView!
    @IBOutlet weak var imageThree: UIImageView!
    @IBOutlet weak var imageFour: UIImageView!
    @IBOutlet weak var imageFive: UIImageView!
    
    @IBOutlet weak var artistOne: UILabel!
    @IBOutlet weak var artistTwo: UILabel!
    @IBOutlet weak var artistThree: UILabel!
    @IBOutlet weak var artistFour: UILabel!
    @IBOutlet weak var artistFive: UILabel!
        var results : [String] = []
    var songName: String = ""
    var songArtist: String = ""
    var albumArt: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        var string1 = ""
        var string2 = ""
        var string3 = ""
        var string4 = ""
        var string5 = ""
        var count = -1
        var a = 5

        imageOne.image = nil
        imageTwo.image = nil
        imageThree.image = nil
        imageFour.image = nil
        imageFive.image = nil
        labelOne.text = ""
        labelTwo.text = ""
        labelThree.text = ""
        labelFour.text = ""
        labelFive.text = ""
        artistOne.text = ""
        artistTwo.text = ""
        artistThree.text = ""
        artistFour.text = ""
        artistFive.text = ""
        sorryButton.text = ""
        wrongResultButton.layer.borderWidth = 0.55
        wrongResultButton.layer.cornerRadius = 10
        if results.count == 0
        {
            sorryButton.text = "Sorry, there are no avaiable results"
        }
        else{
        if results.count < 5
        {
            a = results.count
        }
       
        for i in 0...a - 1
        {
            getSongTitleAndArtistFromLastFM(rawSongName: getSongName(title: results[i]))
            if albumArt.characters.count > 0 && string1 != songArtist && string2 != songArtist && string3 != songArtist && string4 != songArtist && string5 != songArtist && songArtist.lowercased().range(of:"lyric") == nil && songArtist.lowercased().range(of:"lyrics") == nil && songArtist.lowercased().range(of:"/") == nil && songArtist.lowercased().range(of:"-") == nil && songName.lowercased().range(of:"/") == nil && songName.lowercased().range(of:"-") == nil
            {
                count += 1
            
            if count == 0
            {
                string1 = songArtist
                labelOne.text = songName
                get_image(albumArt, imageOne)
                artistOne.text = songArtist
                string1 = songArtist
            }
            if count == 1
            {
                labelTwo.text = songName
                get_image(albumArt, imageTwo)
                artistTwo.text = songArtist
                string2 = songArtist
            }
            if count == 2
            {
                labelThree.text = songName
                get_image(albumArt, imageThree)
                artistThree.text = songArtist
                string3 = songArtist
            }
            if count == 3
            {
                labelFour.text = songName
                get_image(albumArt, imageFour)
                artistFour.text = songArtist
                string4 = songArtist
            }
            if count == 4
            {
                labelFive.text = songName
                get_image(albumArt, imageFive)
                artistFive.text = songArtist
                string5 = songArtist
         
            }
            
                
                
            }
            
            }
            if labelOne.text == ""
            {
                print("Nihihihihihihihi")
                sorryButton.text = "Sorry, there aren't any available results"
            }
            
        }
       

        // Do any additional setup after loading the view.
    }

    
    @IBAction func newResultButton(_ sender: UIButton) {
        

        results = SpeakToMe.crawl(query: SpeakToMe.getSearchAgainFirstElement())
        var string1 = ""
        var string2 = ""
        var string3 = ""
        var string4 = ""
        var string5 = ""
        var count = -1
        var a = 5
        
        imageOne.image = nil
        imageTwo.image = nil
        imageThree.image = nil
        imageFour.image = nil
        imageFive.image = nil
        labelOne.text = ""
        labelTwo.text = ""
        labelThree.text = ""
        labelFour.text = ""
        labelFive.text = ""
        artistOne.text = ""
        artistTwo.text = ""
        artistThree.text = ""
        artistFour.text = ""
        artistFive.text = ""
        sorryButton.text = ""
        wrongResultButton.layer.borderWidth = 0.55
        wrongResultButton.layer.cornerRadius = 10
        if results.count == 0
        {
            sorryButton.text = "Sorry, there are no available results"
        }
        else{
        if results.count < 5
        {
            a = results.count
        }
        
        for i in 0...a - 1
        {
            getSongTitleAndArtistFromLastFM(rawSongName: getSongName(title: results[i]))
            if albumArt.characters.count > 0 && string1 != songArtist && string2 != songArtist && string3 != songArtist && string4 != songArtist && string5 != songArtist && songArtist.lowercased().range(of:"lyric") == nil && songArtist.lowercased().range(of:"lyrics") == nil && songArtist.lowercased().range(of:"/") == nil && songArtist.lowercased().range(of:"-") == nil && songName.lowercased().range(of:"/") == nil && songName.lowercased().range(of:"-") == nil
            {
                count += 1
                
                if count == 0
                {
                    string1 = songArtist
                    labelOne.text = songName
                    get_image(albumArt, imageOne)
                    artistOne.text = songArtist
                    string1 = songArtist
                }
                if count == 1
                {
                    labelTwo.text = songName
                    get_image(albumArt, imageTwo)
                    artistTwo.text = songArtist
                    string2 = songArtist
                }
                if count == 2
                {
                    labelThree.text = songName
                    get_image(albumArt, imageThree)
                    artistThree.text = songArtist
                    string3 = songArtist
                }
                if count == 3
                {
                    labelFour.text = songName
                    get_image(albumArt, imageFour)
                    artistFour.text = songArtist
                    string4 = songArtist
                }
                if count == 4
                {
                    labelFive.text = songName
                    get_image(albumArt, imageFive)
                    artistFive.text = songArtist
                    string5 = songArtist
                    
                }
            }
            
            }
            if labelOne.text == ""
            {
                print("Nihihihihihihihi")
                sorryButton.text = "Sorry, there aren't any available results"
            }
        }
        
    }
    
    
    
    // MARK: - Table view data source
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        return results.count
//    }
//    @IBAction func dismiss(_ sender: UIBarButtonItem) {
//        self.dismiss(animated: false, completion: nil)
//    }
    
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath)
//
//        //        if(count < results.count){
//        //        getSongTitleAndArtistFromLastFM(rawSongName: getSongName(title: results[count]))
//        //        }
//        //        count+=1;
//        //        print(count)
//        //
//
//        //        if albumArt.characters.count > 0 {
//        //            let url = URL(string: albumArt)
//        //            if let data = try? Data(contentsOf: url!){
//        //                cell.imageView?.image = UIImage(data: data)
//        //            }
//        //        } else {
//        //            tableView.deleteRows(at: [indexPath], with: .automatic)
//        //            tableView.reloadData()
//        //        }
//        //
//        //        // Configure the cell...
//        let text = data[indexPath.row]
//        cell.textLabel?.text = songName
//        cell.detailTextLabel?.text = songArtist
//        //cell.textLabel?.text = text
//        return cell
//    }
    
    
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
            
        if title.contains(" – "){
            songName = title.components(separatedBy: " – ")[1]
            if(songName.contains(" | ")){
                songName = songName.components(separatedBy: " | ")[0]
            }
            print("RAW SONG NAME****");
            print(songName + "\n")
        }
        
        if title.contains("Lyrics") {
            songName =  songName.replacingOccurrences(of: "Lyrics", with: "", options: .literal, range: nil)
        }
        
        
        songName = songName.replacingOccurrences(of: "\\s?\\([\\w\\s]*\\)", with: "", options: .regularExpression)
        
        return songName
    }
    
    
    func get_image(_ url_str:String, _ imageView:UIImageView)
    {
        
        let url:URL = URL(string: url_str)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {
            (
            data, response, error) in
            
            
            if data != nil
            {
                let image = UIImage(data: data!)
                
                if(image != nil)
                {
                    
                    DispatchQueue.main.async(execute: {
                        
                        imageView.image = image
                        imageView.alpha = 0
                        
                        UIView.animate(withDuration: 2.5, animations: {
                            imageView.alpha = 1.0
                        })
                        
                    })
                    
                }
                
            }
            
            
        })
        
        task.resume()
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
                        
                        albumArt = trackArray[0]["image"][2]["#text"].string!
                        print("SONG ALBUM ART URL RESULTING FROM API CALL****");
                        print(albumArt + "\n")
                    }
                  
                }
            }
            
            
        }
        
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
