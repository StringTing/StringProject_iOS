//
//  MYEditTableViewCell.swift
//  st_ring
//
//  Created by EuiSuk_Lee on 2017. 10. 16..
//  Copyright © 2017년 EuiSuk_Lee. All rights reserved.
//

import UIKit

class MYEditTableViewCell: UITableViewCell {
    @IBOutlet weak var messageText: UITextView!
    @IBOutlet weak var editbutton: UIButton!
    @IBOutlet weak var messageImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func draw(_ rect: CGRect) {
        let bubbleSpace = CGRect(x: self.messageText.frame.origin.x, y: self.messageText.frame.origin.y, width: self.messageText.frame.width, height: self.bounds.height)
        _ = UIBezierPath(roundedRect: bubbleSpace, byRoundingCorners: [.topLeft , .topRight , .bottomRight], cornerRadii: CGSize(width: 20, height: 20))
        
        let bubblePath = UIBezierPath(roundedRect: bubbleSpace, cornerRadius: 20.0)
        
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        bubblePath.stroke()
        bubblePath.fill()
        
        var triangleSpace = CGRect(x: 0, y: self.bounds.height - 20, width: 20, height: 20)
        let trianglePath = UIBezierPath()
        let startPoint = CGPoint(x: 20.0, y: self.bounds.height - 40)
        let tipPoint = CGPoint(x: 0.0, y: self.bounds.height - 30)
        let endPoint = CGPoint(x: 20.0, y: self.bounds.height - 20)
        trianglePath.move(to: startPoint)
        trianglePath.addLine(to: tipPoint)
        trianglePath.addLine(to: endPoint)
        trianglePath.close()
        UIColor.blue.setStroke()
        UIColor.blue.setFill()
        trianglePath.stroke()
        trianglePath.fill()
        
        
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //        var backgroundImage = UIImageView(image: UIImage(named: "star"))
        //        backgroundImage.contentMode = UIViewContentMode.ScaleAspectFit
        //        self.backgroundView = backgroundImage
    }
    
    
}
