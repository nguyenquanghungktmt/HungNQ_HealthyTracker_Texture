//
//  NewsFeedCell.swift
//  DemoTexture
//
//  Created by Nguyen Quang Hung on 26/07/2022.
//

import UIKit
import AsyncDisplayKit

enum NewFeedTableViewCellType {
    case news
    case promotion
}

class NewsFeedCell : ASCellNode {
    var lbTitle     = ASTextNode()
    var btnViewAll  = ASButtonNode()
    var clvNews     : ASCollectionNode = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = 0
        return ASCollectionNode(collectionViewLayout: flowLayout)
    }()
    
    var newsList     : [NewsModel]?
    var promotionList     : [PromotionModel]?
    var typeCell : NewFeedTableViewCellType?
    
    required override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        btnViewAll.setTitle("Xem tất cả", with: UIFont(name: Constants.Font.regular, size: 13), with: Constants.Color.greenBold, for: .normal)
        btnViewAll.setImage(UIImage(named: "ic_right"), for: .normal)
        btnViewAll.semanticContentAttribute = .forceRightToLeft
        
        clvNews.showsHorizontalScrollIndicator = false
    }
    
    func configureViews(newsList: [NewsModel]?){
        self.typeCell = .news
        self.lbTitle.attributedText = NSMutableAttributedString().attrStr(text: "Tin tức", font: UIFont(name: Constants.Font.bold, size: 17),
                                                                          textColor: Constants.Color.fontBlack)
        self.newsList = newsList
        self.promotionList = nil
    }
    
    func configureViews(promotionList: [PromotionModel]?){
        self.typeCell = .promotion
        self.lbTitle.attributedText = NSMutableAttributedString().attrStr(text: "Khuyến Mãi", font: UIFont(name: Constants.Font.bold, size: 17),
                                                                          textColor: Constants.Color.fontBlack)
        self.newsList = nil
        self.promotionList = promotionList
    }
    
    override func didLoad() {
        super.didLoad()
        
        clvNews.delegate = self
        clvNews.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        let titleSpec = ASWrapperLayoutSpec(layoutElement: lbTitle)
        titleSpec.style.flexShrink = 1.0
        titleSpec.style.flexGrow = 1.0
        
        let headerStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 40,
                                            justifyContent: .start,
                                            alignItems: .start,
                                            children: [titleSpec, btnViewAll])
        
        
        let headerSpec  = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16), child: headerStack)
        headerSpec.style.preferredSize = CGSize(width: width, height: 22)

        let collectionViewSpec = ASWrapperLayoutSpec(layoutElement: clvNews)
        collectionViewSpec.style.preferredSize = CGSize(width: width, height: 248)

        let cellSpec = ASStackLayoutSpec.vertical()
        cellSpec.spacing = 16
        cellSpec.children = [headerSpec, collectionViewSpec]
        return cellSpec
    }
}

extension NewsFeedCell: ASCollectionDataSource, ASCollectionDelegate {
    func collectionNode(_ collectionNode: ASCollectionNode, nodeBlockForItemAt indexPath: IndexPath) -> ASCellNodeBlock {

        
        switch self.typeCell {
        case .news:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsCollectionNodeCell()
                let news = self.newsList?[indexPath.item]
                cell.configureCell(news: news)
                return cell
            }
            return nodeBlock
            
        case .promotion:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsCollectionNodeCell()
                let promotion = self.promotionList?[indexPath.item]
                cell.configureCell(promotion: promotion)
                return cell
            }
            return nodeBlock
            
        default:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsCollectionNodeCell()
                cell.setShadow()
                return cell
            }
            return nodeBlock
        }
    }
    
    func numberOfSections(in collectionNode: ASCollectionNode) -> Int {
        return 1
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        switch self.typeCell {
        case .news:
            return newsList?.count ?? 0
            
        case .promotion:
            return promotionList?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: 274, height: 248)
        return ASSizeRange(min: CGSize(width: 0, height: 0), max: size)
    }
}
