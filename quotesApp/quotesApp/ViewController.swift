//
//  ViewController.swift
//  quotesApp
//
//  Created by Kerem Safa Dirican on 19.11.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var labelOutlet: UILabel!
    
    @IBOutlet weak var subLabelOutlet: UILabel!
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getQuote()
    }

    @IBAction func buttonAction(_ sender: Any) {
        buttonOutlet.isEnabled = false
        getQuote()
    }
    
    
    func updateUI(label:String,subLabel:String){
        DispatchQueue.main.async {
            self.labelOutlet.text = label
            self.subLabelOutlet.text = subLabel
            self.buttonOutlet.isEnabled = true
            
        }
    }
    
    
    func getQuote(){
        var request = URLRequest(url: URL(string: "https://programming-quotes-api.herokuapp.com/Quotes/random")!)
        
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request){ [self] (data,response,error) in
            do{
                let quote = try JSONDecoder().decode(Quote.self, from: data!)
                updateUI(label: quote.en, subLabel: quote.author)
                
            }catch{
                buttonOutlet.isEnabled = true
                print(error.localizedDescription)
            }
        }.resume()
    }
}


struct Quote: Codable {
    let id, author, en: String
}
