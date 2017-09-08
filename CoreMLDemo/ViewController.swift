//
//  ViewController.swift
//  CoreMLDemo
//
//  Created by webwerks on 08/09/17.
//  Copyright © 2017 smart. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageCategoryLabel: UILabel!
    
    let model = GoogLeNetPlaces()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func singleTapGestureOnImage(_ sender: UITapGestureRecognizer) {
        
        let imageView = sender.view as? UIImageView
        
        if let imageToPredict = imageView?.image {
            if let sceneLabelString = findImageCategory(forImage: imageToPredict) {
                imageCategoryLabel.text = sceneLabelString
            }
        }
        
    }
    
    func findImageCategory (forImage image:UIImage) -> String? {
        if let imagePixelBuffer = ImageProcessor.pixelBuffer(forImage: image.cgImage!) {
            guard let predictedView = try? model.prediction(sceneImage: imagePixelBuffer) else {fatalError("runtime error")}
            return predictedView.sceneLabel
            
        }
        
        return nil
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

