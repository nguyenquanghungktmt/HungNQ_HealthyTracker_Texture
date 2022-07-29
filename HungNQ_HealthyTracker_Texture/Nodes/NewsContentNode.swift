//
//  NewsFeedCellNode.swift
//  DemoTexture
//
//  Created by Nguyen Quang Hung on 20/07/2022.
//

import AsyncDisplayKit

class NewsCellNode : ASDisplayNode {
    let imgNews = ASNetworkImageNode()
    let title = ASTextNode()
    let category = ASTextNode()
    let date = ASTextNode()
    let point = ASDisplayNode()
    let background = ASDisplayNode()
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        self.clipsToBounds = true
        
        self.addSubnode(imgNews)
        self.addSubnode(title)
        self.addSubnode(category)
        self.addSubnode(date)
        self.addSubnode(point)
        
        self.imgNews.contentMode = .scaleToFill
        self.point.backgroundColor = Constants.Color.grayLight
        self.point.cornerRadius = 2
    }
    
    
    func configureView(news: NewsModel?){
        self.imgNews.url = URL(string: news?.picture ?? "")
        self.title.attributedText = NSMutableAttributedString().attrStr(text: news?.title ?? " ",
                                                                        font: UIFont(name: Constants.Font.bold, size: 15),
                                                                        textColor: Constants.Color.fontBlack)
        self.category.attributedText = NSMutableAttributedString().attrStr(text: news?.category_name ?? " ",
                                                                           font: UIFont(name: Constants.Font.bold, size: 13),
                                                                           textColor: Constants.Color.greenBold)
        self.date.attributedText = NSMutableAttributedString().attrStr(text: news?.created_at ?? " ",
                                                                        font: UIFont(name: Constants.Font.regular, size: 13),
                                                                        textColor: Constants.Color.grayLight)
    }
    
    func configureView(promotion: PromotionModel?){
        self.imgNews.url = URL(string: promotion?.picture ?? "")
        self.title.attributedText = NSMutableAttributedString().attrStr(text: promotion?.name ?? " ",
                                                                        font: UIFont(name: Constants.Font.bold, size: 15),
                                                                        textColor: Constants.Color.fontBlack)
        self.category.attributedText = NSMutableAttributedString().attrStr(text: promotion?.category_name ?? " ",
                                                                           font: UIFont(name: Constants.Font.bold, size: 13),
                                                                           textColor: Constants.Color.greenBold)
        self.date.attributedText = NSMutableAttributedString().attrStr(text: promotion?.created_at ?? " ",
                                                                        font: UIFont(name: Constants.Font.regular, size: 13),
                                                                        textColor: Constants.Color.grayLight)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        // layout for news image
        let imgNewsSpec = ASWrapperLayoutSpec(layoutElement: imgNews)
        imgNewsSpec.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 134)
        
        // layout for content below
        let pointSpec = ASWrapperLayoutSpec(layoutElement: point)
        pointSpec.style.preferredSize = CGSize(width: 4, height: 4)
        
        let subContentStack = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 6,
                                                justifyContent: .center,
                                                alignItems: .center,
                                                children: [category, pointSpec, date])
        
        let contentStack = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 4,
                                             justifyContent: .start,
                                             alignItems: .start,
                                             children: [title, subContentStack])
            
        let contentSpec = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12), child: contentStack)
        
        let newsStack = ASStackLayoutSpec.vertical()
        newsStack.children = [imgNewsSpec, contentSpec]
    
        return newsStack
    }
}
