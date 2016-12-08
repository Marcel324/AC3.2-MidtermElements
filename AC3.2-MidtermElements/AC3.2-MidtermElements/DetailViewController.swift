//
//  DetailViewController.swift
//  AC3.2-MidtermElements
//
//  Created by Marcel Chaucer on 12/8/16.
//  Copyright © 2016 Marcel Chaucer. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var anElement: Element!
    var postEndPoint = "https://api.fieldbook.com/v1/58488d40b3e2ba03002df662/favorites"
    
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var elementImage: UIImageView!
    
    @IBOutlet weak var meltingAndBoilingPoints: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = anElement?.name
        self.nameLabel.text = anElement.name
        self.numberLabel.text = String(describing: anElement.number)
        self.weightLabel.text = "[\(String(describing: anElement.weight))]"
        self.symbolLabel.text = anElement.symbol
        self.meltingAndBoilingPoints.text = "Melting Point: \(anElement.melting_c)°C;  Boiling Point: \(anElement.boiling_c)°C"
        getImage()
            }
    
    func getImage() {
        let largeImage = "https://s3.amazonaws.com/ac3.2-elements/\(anElement!.symbol).png"
        APIRequestManager.manager.getData(endPoint: largeImage) { (data: Data?) in
            if let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.elementImage.image = validImage
                }
            }
        }
    }
    
    @IBAction func postToFavorite(_ sender: UIButton) {
        let bodyDict: [String:Any] = ["my_name": "Marcel", "favorite_element": self.anElement.symbol]
        APIRequestManager.manager.postRequest(endPoint: postEndPoint, data: bodyDict)
    }
}
    
