//
//  Crawler.swift
//  SpeakToMe
//
//  Created by Rohan Katakam on 7/20/18.
//  Copyright © 2018 Henry Mason. All rights reserved.
//

import Foundation
import SwiftSoup

func crawl(query: String){
    let input = query.replacingOccurrences(of: " ", with: "+", options: .literal, range: nil)
    let url = "https://www.google.com/search?q=\(input)"
    guard let myURL = URL(string: url) else {
        print("Error: \(url) doesn't seem to be a valid URL")
        return
    }
    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        do {
            let doc: Document = try SwiftSoup.parse(myHTMLString)
            guard let results : Elements = try? doc.getElementsByClass("g") else {return}
            guard let titles : Elements = try? doc.getElementsByTag("h3") else {return}
            guard let urls : Elements = try? doc.getElementsByTag("cite") else {return}
            var count = 0;
            //for title: Element in titles{
                
                
            //}
            for url: Element in urls{
                if try url.text().lowercased().contains("soundcloud") || url.text().lowercased().contains("youtube")||url.text().lowercased().contains("metrolyrics") || url.text().lowercased().contains("genius") || url.text().lowercased().contains("azlyrics") || url.text().lowercased().contains("lyrics")||url.text().lowercased().contains("song"){
                    print(try titles.get(count).text())
                    print(try url.text() + "\n")
                }
                count+=1;
            }
          //  for result: Element in results {
            //    print(try result.text() + "\n")
            //gd}
            
        } catch Exception.Error(let message) {
            print(message)
        } catch {
            print("error")
        }
        //print("HTML : \(myHTMLString)")
    } catch let error {
        print("Error: \(error)")
    }
}

