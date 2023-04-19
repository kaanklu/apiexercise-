//
//  ViewController.swift
//  oneofapiexercise
//
//  Created by Kaan Kalaycıoğlu on 19.04.2023.
//

import UIKit
import SDWebImage

class ViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    var imageLink = String()
    var labellink : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
    }


    @IBAction func buttonClicked(_ sender: Any) {
        //1.adım
        let url = URL(string: "https://some-random-api.ml/animal/koala")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        //2.adım
        let dataTask = session.dataTask(with: request) { data, response, error in
            if let error = error {
                print(error.localizedDescription ?? "error")
            }
            guard let data = data else {
                print("error")
                return
            }
                do {
                    if let jsonObject = try JSONSerialization.jsonObject(with: data) as? Dictionary<String,String> {
                        self.labellink = jsonObject["fact"]!
                        self.imageLink = jsonObject["image"]!
                        var imageurl = URL(string: self.imageLink)
                        DispatchQueue.main.async {
                            
                            self.myLabel.text = self.labellink
                            self.imageView.sd_setImage(with: imageurl, placeholderImage: nil, options: SDWebImageOptions.highPriority, completed: nil)
                        }
                        
                        
                        
                    }
                
                }catch{
                    print("error")
                }
                
                
            
            
        }.resume()
        
    }
}

