//
//  ViewController.swift
//  Silly Song
//
//  Created by Lucien George on 03/11/2022.
//

import UIKit

func shortNameFromName(name: String) -> String {
    var name = name
    let vowels: CharacterSet = CharacterSet(charactersIn: "aeiouy")
    name = name.lowercased()
    while !CharacterSet(charactersIn: String(name[name.startIndex])).isSubset(of: vowels) {
        name.remove(at: name.startIndex)
    }
    return name
}

func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    var lyricsTemplate = lyricsTemplate
    lyricsTemplate.replace(/<FULL_NAME>/, with: fullName)
    lyricsTemplate.replace(/<SHORT_NAME>/, with: shortNameFromName(name: fullName))
    return lyricsTemplate
}

let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

class ViewController: UIViewController {

    @IBOutlet weak var lyricsField: UITextView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nameField.delegate = self
        nameField.returnKeyType = UIReturnKeyType.done
    }
    
    @IBAction func reset(_ sender: Any) {
        lyricsField.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if nameField.text?.isEmpty ?? false {
            return
        }
        lyricsField.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

