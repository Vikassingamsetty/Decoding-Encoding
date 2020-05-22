//
//  ViewController.swift
//  Decoding & Encoding
//
//  Created by Srans022019 on 05/05/20.
//  Copyright © 2020 vikas. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var table: UITableView!
    
    var name = [String]()
    var phoneNumber = [String]()
    var getImage = [UIImage]()
    
    var x = Response()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       serverData()
        
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "cell")
       
    }
    
    
    func serverData() {
        
        let url = URL(string: "https://foodie.deliveryventure.com/shops/data")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard let data = data else {return}
            
            do{
                self.x = try JSONDecoder().decode(Response.self, from: data)
            }catch{
                print(error)
            }
            
            for shop in self.x.shops ?? [Shop]() {
                guard let image = UIImage(url: URL(string: shop.avatar!)) else {return}
                self.getImage.append(image)
                self.name.append(shop.name!)
                self.phoneNumber.append(shop.phone!)
                
            }
            
            DispatchQueue.main.async {
                self.table.reloadData()
            }
            
        }
        
        task.resume()
        
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return name.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        cell.nameLabel.text = name[indexPath.row]
        cell.phoneNumberLabel.text = phoneNumber[indexPath.row]
        cell.imageVIew.image = getImage[indexPath.row]
        
        return cell
    }
    
}

//MARk:- UIImage extension
extension UIImage {
    convenience init?(url: URL?) {
        guard let url = url else { return nil }
        
        do {
            let data = try Data(contentsOf: url)
            self.init(data: data)
        } catch {
            print("Cannot load image from url: \(url) with error: \(error)")
            return nil
        }
    }
}

