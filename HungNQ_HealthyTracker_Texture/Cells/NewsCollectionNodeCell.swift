//
//  NewsCollectionNodeCell.swift
//  DemoTexture
//
//  Created by Nguyen Quang Hung on 29/07/2022.
//

import AsyncDisplayKit

class NewsCollectionNodeCell: ASCellNode {
    var newsContent = NewsCellNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        newsContent.backgroundColor = .white
        newsContent.cornerRadius = 8
        newsContent.clipsToBounds = true
        
        setShadow()
    }
    
    func configureCell(news: NewsModel?) {
        newsContent.configureView(news: news)
    }
    
    func configureCell(promotion: PromotionModel?) {
        newsContent.configureView(promotion: promotion)
    }
    
    func setShadow() {
        self.shadowColor = UIColor.gray.cgColor
        self.shadowOffset = CGSize(width: 0.0, height: 4.0)
        self.shadowRadius = 5.0
        self.shadowOpacity = 0.2
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 28, right: 0), child: newsContent)
    }
}
