//
//  UIImage+Extensions.swift
//  HealthyTracker
//
//  Created by pc_1359 on 30/06/2022.
//

import UIKit

extension UIImage {
  class func imageWithColor(color: UIColor) -> UIImage {
    let rect: CGRect = CGRect(x: 0, y: 0, width: 1, height: 1)
    UIGraphicsBeginImageContextWithOptions(CGSize(width: 1, height: 1), false, 0)
    color.setFill()
    UIRectFill(rect)
    let image: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
    
    func makeCircularImage(size: CGSize, borderWidth width: CGFloat) -> UIImage {
        // make a CGRect with the image's size
        let circleRect = CGRect(origin: .zero, size: size)

        // begin the image context since we're not in a drawRect:
        UIGraphicsBeginImageContextWithOptions(circleRect.size, false, 0)

        // create a UIBezierPath circle
        let circle = UIBezierPath(roundedRect: circleRect, cornerRadius: circleRect.size.width * 0.5)

        // clip to the circle
        circle.addClip()

        UIColor.white.set()
        circle.fill()

        // draw the image in the circleRect *AFTER* the context is clipped
        self.draw(in: circleRect)

        // create a border (for white background pictures)
        if width > 0 {
            circle.lineWidth = width;
            UIColor.white.set()
            circle.stroke()
        }

        // get an image from the image context
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext();

        // end the image context since we're not in a drawRect:
        UIGraphicsEndImageContext();

        return roundedImage ?? self
    }

    class func draw(size: CGSize, fillColor: UIColor, shapeClosure: () -> UIBezierPath) -> UIImage {
        UIGraphicsBeginImageContext(size)

        let path = shapeClosure()
        path.addClip()

        fillColor.setFill()
        path.fill()

        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return image!
    }

}
