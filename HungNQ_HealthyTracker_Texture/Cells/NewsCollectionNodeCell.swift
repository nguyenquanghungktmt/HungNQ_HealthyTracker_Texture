//
//  NewsCollectionNodeCell.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 29/07/2022.
//

import AsyncDisplayKit

class NewsCollectionNodeCell: ASCellNode {
    var newsCell = NewsCellNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.addSubnode(newsCell)
        
        newsCell.backgroundColor = .white
        newsCell.cornerRadius = 8
        
        setShadow()
    }
    
    func configureCell(news: NewsModel?) {
        newsCell.configureView(news: news)
    }
    
    func configureCell(promotion: PromotionModel?) {
        newsCell.configureView(promotion: promotion)
    }
    
    func setShadow() {
        self.shadowColor = UIColor.gray.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.shadowRadius = 5.0
        self.shadowOpacity = 0.2
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: Constants.Inset.insetForCltCell, child: newsCell)
    }
}
