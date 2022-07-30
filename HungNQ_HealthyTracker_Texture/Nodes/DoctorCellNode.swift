//
//  DoctorCellNode.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 30/07/2022.
//

import AsyncDisplayKit

class DoctorCellNode: ASDisplayNode {
    var imgDoctor       = ASNetworkImageNode()
    var lbName          = ASTextNode()
    var lbMajor         = ASTextNode()
    var lbRating          = ASTextNode()
    var imgStar         = ASImageNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.clipsToBounds = true
        
        self.addSubnode(imgDoctor)
        self.addSubnode(lbName)
        self.addSubnode(lbMajor)
        self.addSubnode(lbRating)
        self.addSubnode(imgStar)
        
        self.imgDoctor.defaultImage = UIImage(named: "img_doctor_placehold")
        self.imgDoctor.cornerRadius = 6
        self.imgStar.image = UIImage(named: "ic_star")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        let imageDoctorSpec = ASWrapperLayoutSpec(layoutElement: imgDoctor)
        imageDoctorSpec.style.preferredSize = CGSize(width: width - 24, height: width - 24)
        
        let textStack = ASStackLayoutSpec(direction: .vertical,
                                          spacing: 0,
                                          justifyContent: .start,
                                          alignItems: .start,
                                          children: [lbName, lbMajor])

        let imageStarSpec = ASWrapperLayoutSpec(layoutElement: imgStar)
        imageStarSpec.style.preferredSize = CGSize(width: 12, height: 12)
        let ratingStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 6,
                                            justifyContent: .start,
                                            alignItems: .center,
                                            children: [imageStarSpec, lbRating])
        
        let spacing1 = ASLayoutSpec()
        spacing1.style.preferredSize.height = 12
        let spacing2 = ASLayoutSpec()
        spacing2.style.preferredSize.height = 4
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [imageDoctorSpec, spacing1, textStack, spacing2, ratingStack]
        
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), child: contentStack)
    }
    
    func configureCell(doctor: DoctorModel?) {
        self.imgDoctor.url = URL(string: doctor?.avatar ?? "")
        self.imgDoctor.placeholderColor = .gray
        self.lbName.attributedText = NSMutableAttributedString().attrStr(text: doctor?.name ?? " ",
                                                                         font: UIFont(name: Constants.Font.bold, size: 13),
                                                                         textColor: Constants.Color.fontBlack)
        self.lbMajor.attributedText = NSMutableAttributedString().attrStr(text: doctor?.majors_name ?? " ",
                                                                          font: UIFont(name: Constants.Font.regular, size: 12),
                                                                          textColor: Constants.Color.grayLight)
        self.lbRating.attributedText = NSMutableAttributedString()
            .attrStr(text: "\(doctor?.ratio_star ?? 0) ", font: UIFont(name: Constants.Font.regular, size: 11))
            .attrStr(text: "(\(doctor?.number_of_reviews ?? 0))", font: UIFont(name: Constants.Font.regular, size: 11), textColor: UIColor.lightGray )
        
    }
}
