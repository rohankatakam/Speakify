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
    let url = "http://www.metrolyrics.com/search.html?search=\(input)"
    guard let myURL = URL(string: url) else {
        print("Error: \(url) doesn't seem to be a valid URL")
        return
    }
    do {
        let myHTMLString = try String(contentsOf: myURL, encoding: .ascii)
        do {
            let doc: Document = try SwiftSoup.parse(myHTMLString)
            guard let results : Elements = try? doc.getElementsByClass("ng-binding") else {return}
            for result: Element in results {
                print(try result.text())
            }
            
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

