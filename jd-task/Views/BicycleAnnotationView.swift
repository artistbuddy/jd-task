//
//  BicycleAnnotationView.swift
//  jd-task
//
//  Created by XCodeClub on 2018-07-08.
//  Copyright © 2018 Karol. All rights reserved.
//

import UIKit
import MapKit

class BicycleAnnotationView: MKAnnotationView {
    static let reusableID = "Station Bicycle"
    
    var bikes: String? {
        didSet {
            if let bikes = self.bikes {
                let style = NSMutableParagraphStyle()
                style.alignment = .center
                let attribs: [NSAttributedStringKey : Any] = [.foregroundColor : UIColor.green,
                                                              .font : UIFont(name: "HelveticaNeue-Bold", size: 35)!,
                                                              .paragraphStyle : style]
                
                let text = NSAttributedString(string: bikes, attributes: attribs)
                self.countLabel.attributedText = text
            }
        }
    }
    
    private lazy var bicycleView: UIView = {
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.cornerRadius = 20
        backgroundView.clipsToBounds = true
        
        let image = UIImage(named: "bicycle")
        let imageView = UIImageView(image: image)
        imageView.frame = backgroundView.bounds.insetBy(dx: 10, dy: 10)
        
        backgroundView.addSubview(imageView)
        
        return backgroundView
    }()
    
    private lazy var countLabel: UILabel = {
        return UILabel(frame: CGRect(x: 40, y: 0, width: 40, height: 40))
    }()
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func prepareForReuse() {
        self.bikes = ""
    }
    
    private func setupView() {
        self.frame = CGRect(x: 0, y: 0, width: 80, height: 40)
        self.backgroundColor = UIColor.clear
        
        self.addSubview(self.bicycleView)
        self.addSubview(self.countLabel)
    }
    
}
