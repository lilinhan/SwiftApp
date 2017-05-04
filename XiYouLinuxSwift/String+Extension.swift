//
//  String+Extension.swift
//  XiYouLinuxSwift
//
//  Created by lewin丶 on 2017/5/3.
//  Copyright © 2017年 lewin丶. All rights reserved.
//

import UIKit

extension String {
    //    constrainedToSize 如果一行，用CGSizeZero，否则用CGSizeMake(你想要的宽度, CGFloat(MAXFLOAT)
    func textSizeWithFont(font: UIFont, constrainedToSize size:CGSize) -> CGSize {
        var textSize:CGSize!
        if size.equalTo(CGSize.zero) {
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            textSize = self.size(attributes: attributes as? [String : AnyObject])
        } else {
            let option = NSStringDrawingOptions.usesLineFragmentOrigin
            let attributes = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
            let stringRect = self.boundingRect(with: size, options: option, attributes: attributes as? [String : AnyObject], context: nil)
            textSize = stringRect.size
        }
        return textSize
    }
}
