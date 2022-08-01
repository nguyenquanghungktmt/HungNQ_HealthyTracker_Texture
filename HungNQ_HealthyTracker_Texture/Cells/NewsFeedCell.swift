//
//  NewsFeedCell.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 26/07/2022.
//

import UIKit
import AsyncDisplayKit

enum NewFeedTableViewCellType {
    case news
    case promotion
    case doctor
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
    
    var newsList            : [NewsModel]?
    var promotionList       : [PromotionModel]?
    var doctorList          : [DoctorModel]?
    var typeCell            : NewFeedTableViewCellType?
    
    required override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        btnViewAll.setTitle("Xem tất cả", with: UIFont(name: Constants.Font.regular, size: 13), with: Constants.Color.greenBold, for: .normal)
        btnViewAll.setImage(UIImage(named: "ic_right2"), for: .normal)
        btnViewAll.semanticContentAttribute = .forceRightToLeft
        
        register()
        clvNews.showsHorizontalScrollIndicator = false
    }
    
    func configureViews(newsList: [NewsModel]?){
        self.typeCell = .news
        self.lbTitle.attributedText = NSMutableAttributedString().attrStr(text: "Tin tức", font: UIFont(name: Constants.Font.bold, size: 17),
                                                                          textColor: Constants.Color.fontBlack)
        self.newsList = newsList
        self.promotionList = nil
        self.doctorList = nil
    }
    
    func configureViews(promotionList: [PromotionModel]?){
        self.typeCell = .promotion
        self.lbTitle.attributedText = NSMutableAttributedString().attrStr(text: "Khuyến Mãi", font: UIFont(name: Constants.Font.bold, size: 17),
                                                                          textColor: Constants.Color.fontBlack)
        self.newsList = nil
        self.promotionList = promotionList
        self.doctorList = nil
    }
    
    func configureViews(doctorList: [DoctorModel]?){
        self.typeCell = .doctor
        self.lbTitle.attributedText = NSMutableAttributedString().attrStr(text: "Giới thiệu bác sĩ", font: UIFont(name: Constants.Font.bold, size: 17),
                                                                          textColor: Constants.Color.fontBlack)
        self.newsList = nil
        self.promotionList = nil
        self.doctorList = doctorList
    }
    
    func register() {
        clvNews.delegate = self
        clvNews.dataSource = self
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let width = constrainedSize.max.width
        
        // Layout for header
        let titleSpec = ASWrapperLayoutSpec(layoutElement: lbTitle)
        titleSpec.style.flexShrink = 1.0
        titleSpec.style.flexGrow = 1.0
        
        let headerStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 40,
                                            justifyContent: .start,
                                            alignItems: .center,
                                            children: [titleSpec, btnViewAll])
        
        
        let headerSpec  = ASInsetLayoutSpec(insets: Constants.Inset.insetForHeaderTbvCell, child: headerStack)
        headerSpec.style.preferredSize = CGSize(width: width, height: 22)

        // Layout for collection node
        let collectionSpec = ASWrapperLayoutSpec(layoutElement: clvNews)
        collectionSpec.style.preferredSize = CGSize(width: width, height: (self.typeCell == .doctor ?
                                                                        Constants.HomeVC.cltDoctorCellSize.height :
                                                                                Constants.HomeVC.cltNewsCellSize.height))

        let cellSpec = ASStackLayoutSpec.vertical()
        cellSpec.spacing = 16
        cellSpec.children = [headerSpec, collectionSpec]
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
            
        case .doctor:
            let nodeBlock: ASCellNodeBlock = {
                let cell = DoctorCollectionNodeCell()
                let doctor = self.doctorList?[indexPath.item]
                cell.configureViews(doctor: doctor)
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
            
        case .doctor:
            return doctorList?.count ?? 0
            
        default:
            return 0
        }
    }
    
    func collectionNode(_ collectionNode: ASCollectionNode, constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        let size = (self.typeCell == .doctor ?
                        Constants.HomeVC.cltDoctorCellSize :
                        Constants.HomeVC.cltNewsCellSize )
        return ASSizeRange(min: CGSize(width: 0, height: 0), max: size)
    }
}
