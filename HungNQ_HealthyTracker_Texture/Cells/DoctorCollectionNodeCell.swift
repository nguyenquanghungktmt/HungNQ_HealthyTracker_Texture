//
//  DoctorCollectionNodeCell.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 30/07/2022.
//

import AsyncDisplayKit

class DoctorCollectionNodeCell: ASCellNode {
    var doctorCell = DoctorCellNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        setupView()
    }

    func setupView() {
        doctorCell.backgroundColor = .white
        doctorCell.cornerRadius = 8
        doctorCell.borderWidth = 1
        doctorCell.borderColor = Constants.Color.borderGray.cgColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: Constants.Inset.insetForCltCell, child: doctorCell)
    }
    
    func configureViews(doctor: DoctorModel?) {
        doctorCell.configureCell(doctor: doctor)
    }
}
