//
//  Crawler.swift
//  SpeakToMe
//
//  Created by Rohan Katakam on 7/20/18.
//  Copyright © 2018 Henry Mason. All rights reserved.
//

import Foundation
import SwiftSoup


var inputForOtherFiles: String = ""
var searchAgainFirstElement:String = ""
func crawl(query: String) -> [String]{
    var titleList : [String] = []
    var input = query.replacingOccurrences(of: " ", with: "%20", options: .literal, range: nil)
    input = input.replacingOccurrences(of: "’", with: "%27", options: .literal, range: nil)
    input = input.replacingOccurrences(of: ",", with: "%2C", options: .literal, range: nil)
    
    
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
            searchAgainFirstElement = (try doc.select("p").first()?.text())!
            var count = 0;
 
            for url: Element in urls{
                if try url.text().lowercased().contains("soundcloud") || url.text().lowercased().contains("youtube")||url.text().lowercased().contains("metrolyrics") || url.text().lowercased().contains("genius") || url.text().lowercased().contains("azlyrics"){
                    if(try titles.get(count).text().contains(" - ") || titles.get(count).text().contains(" – ")){
                        titleList.append(try titles.get(count).text())
                        
                    }
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
    print(titleList.count)
    return titleList
}

func getSearchAgainFirstElement() -> String{
    print(searchAgainFirstElement)
    return searchAgainFirstElement
}

