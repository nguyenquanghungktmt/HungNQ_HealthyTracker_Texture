//
//  HomeNode.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 29/07/2022.
//

import AsyncDisplayKit

class HomeNode: ASDisplayNode {
    lazy var loading        = UIActivityIndicatorView()
    lazy var refreshControl = UIRefreshControl()
    
    var userNode        = UserNode()
    var newsTableNode   = ASTableNode()
    var viewContent     = ASDisplayNode()
    
    var newsFeed : PatientNewsFeedModel?
    var safeArea : UIEdgeInsets?
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        self.addSubnode(userNode)
        self.addSubnode(newsTableNode)
        self.addSubnode(viewContent)

        viewContent.backgroundColor = UIColor.white
        viewContent.cornerRadius = 20
        
        newsTableNode.allowsSelection = false
        newsTableNode.view.separatorStyle = .none
        newsTableNode.view.showsVerticalScrollIndicator = false
        
        newsTableNode.delegate = self
        newsTableNode.dataSource = self
    }
    
    @objc
    func fetchDataNewsFeed() {
        //load data here
        APIUtilities.requestHomePatientNewsFeed { [weak self] newsFeedResult, error in
            guard let self = self else { return}
            
            guard let newsFeedResult = newsFeedResult, error == nil else {
                return
            }
            self.newsFeed = newsFeedResult

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return}
                self.newsTableNode.reloadData()
            }
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backgroundSpec = ASWrapperLayoutSpec(layoutElement: viewContent)
        backgroundSpec.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height - 123)
        
        let contentSpec = ASOverlayLayoutSpec(child: backgroundSpec,
                                              overlay: ASInsetLayoutSpec(insets: UIEdgeInsets(top: 20, left: 0, bottom: safeArea?.bottom ?? 0, right: 0), child: newsTableNode))
        
        return ASStackLayoutSpec(direction: .vertical,
                                 spacing: -20,
                                 justifyContent: .center,
                                 alignItems: .center,
                                 children: [userNode, contentSpec])
    }
}
// MARK: ASTableDataSource / ASTableDelegate
extension HomeNode: ASTableDataSource, ASTableDelegate {
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        switch indexPath.item {
        case 0:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsFeedCell()
                cell.configureViews(newsList: self.newsFeed?.newsList)
                return cell
            }
            return nodeBlock
        case 1:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsFeedCell()
                cell.configureViews(promotionList: self.newsFeed?.promotionList)
                return cell
            }
            return nodeBlock
        case 2:
            let nodeBlock: ASCellNodeBlock = {
                let cell = NewsFeedCell()
                cell.configureViews(doctorList: self.newsFeed?.doctorList)
                return cell
            }
            return nodeBlock
        default:
            let nodeBlock: ASCellNodeBlock = {
                let cell = ASCellNode()
                return cell
            }
            return nodeBlock
        }
    }
    
    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        let size = CGSize(width: self.bounds.width, height: (indexPath.item == 2 ?
                                                                Constants.HomeVC.tableDoctorCellHeight :
                                                                Constants.HomeVC.tableNewsCellHeight))
        return ASSizeRange(min: size, max: size)
    }
    
    func shouldBatchFetchForCollectionNode(collectionNode: ASCollectionNode) -> Bool {
        return true
    }
}
