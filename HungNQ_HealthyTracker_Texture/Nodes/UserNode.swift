//
//  UserView.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 29/07/2022.
//

import AsyncDisplayKit

class UserNode: ASDisplayNode {
    var lbUsername  = ASTextNode()
    var lbStatus    = ASTextNode()
    var imgAvatar   = ASImageNode()
    var point       = ASDisplayNode()
    var imgBackground = ASImageNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.imgBackground.clipsToBounds = true
        
        self.backgroundColor = .white
        
        self.addSubnode(lbUsername)
        self.addSubnode(lbStatus)
        self.addSubnode(imgAvatar)
        self.addSubnode(point)
        self.addSubnode(imgBackground)
        
        lbUsername.attributedText = NSMutableAttributedString().attrStr(text: "Quỳnh Ken", font: UIFont(name: Constants.Font.bold, size: 17), textColor: .white)
        lbStatus.attributedText = NSMutableAttributedString().attrStr(text: "Đang trực tuyến", font: UIFont(name: Constants.Font.regular, size: 13), textColor: .white)
        
        point.backgroundColor = .green
        point.cornerRadius = 4
        
        imgAvatar.image = UIImage(named: "img_user_avatar")
        imgAvatar.cornerRadius = 21
        
        imgBackground.image = UIImage(named: "img_background_home")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        let imgBackgroundSpec = ASWrapperLayoutSpec(layoutElement: imgBackground)
        imgBackground.style.preferredSize = CGSize(width: width, height: 143)
        
        let pointSpec = ASWrapperLayoutSpec(layoutElement: point)
        pointSpec.style.preferredSize = CGSize(width: 8, height: 8)
        
        let statusSpec = ASStackLayoutSpec(direction: .horizontal,
                                           spacing: 4,
                                           justifyContent: .start,
                                           alignItems: .center,
                                           children: [pointSpec, lbStatus])
        
        let infoSpec = ASStackLayoutSpec.vertical()
        infoSpec.style.flexShrink = 1.0
        infoSpec.style.flexGrow = 1.0
        infoSpec.children = [lbUsername, statusSpec]
        
        let userStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 40,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [infoSpec, imgAvatar])
        
        let userSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 60, left: 16, bottom: CGFloat.infinity, right: 16), child: userStack)
        
        return ASOverlayLayoutSpec(child: imgBackgroundSpec, overlay: userSpec)
    }
}
