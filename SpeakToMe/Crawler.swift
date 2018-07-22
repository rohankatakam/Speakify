//
//  Crawler.swift
//  SpeakToMe
//
//  Created by Rohan Katakam on 7/20/18.
//  Copyright © 2018 Henry Mason. All rights reserved.
//

import Foundation
import SwiftSoup

struct songs {
    static var titleList : [String] = []
    static var urlList: [String] = []
}

func crawl(query: String) -> [String]{
    var input = query.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    songs.titleList = []
    songs.urlList = []
    
    input = input.replacingOccurrences(of: "'", with: "%27", options: .literal, range: nil)
    
    var url = "https://www.google.com/search?&q=\(input)"
    guard let myURL = URL(string: url) else {
        print("Error: \(url) doesn't seem to be a valid URL")
        return []
    }
    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        do {
            let doc: Document = try SwiftSoup.parse(myHTMLString)
            guard let results : Elements = try? doc.getElementsByClass("g") else {return []}
            guard let titles : Elements = try? doc.getElementsByTag("h3") else {return []}
            guard let urls : Elements = try? doc.getElementsByTag("cite") else {return []}
            var count = 0;
            //for title: Element in titles{
            
            
            //}
            for url: Element in urls{
                if try url.text().lowercased().contains("soundcloud") || url.text().lowercased().contains("youtube")||url.text().lowercased().contains("metrolyrics") || url.text().lowercased().contains("genius") || url.text().lowercased().contains("azlyrics") || url.text().lowercased().contains("lyrics")||url.text().lowercased().contains("song"){
                    songs.titleList.append(try titles.get(count).text())
                    songs.urlList.append(try url.text())
                    //print(try url.text() + "\n")
                }
                count+=1;
                
            }
            
        } catch Exception.Error(let type, let message) {
            print(message)
        } catch {
            print("error")
        }
        //print("HTML : \(myHTMLString)")
    } catch let error {
        print("Error: \(error)")
    }
    
    return songs.titleList
}


