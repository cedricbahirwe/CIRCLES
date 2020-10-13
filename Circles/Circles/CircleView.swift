//
//  CircleView.swift
//  Circles
//
//  Created by Cedric Bahirwe on 5/27/20.
//  Copyright © 2020 Cedric Bahirwe. All rights reserved.
//

import UIKit

class CircleView: UIView {

    var colors: [UIColor] = [.blue, .yellow, .green, .lightGray, .purple, .red, .brown, .magenta, .orange, .systemRed]
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        let randomColor: UIColor = colors.randomElement()!
        // Drawing code
        // Get the Graphics context
        let context = UIGraphicsGetCurrentContext()
        
        // Set the border width
        context?.setLineWidth(5.0)
        // Set the border color
        randomColor.set()
        
        // Create the circle
        let center = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        let radius = (frame.size.width - 10 ) / 2
        context?.addArc(center: center, radius: radius, startAngle: 0.0, endAngle: .pi * 2.0 , clockwise: true)
        
        context?.strokePath()
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
        
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
