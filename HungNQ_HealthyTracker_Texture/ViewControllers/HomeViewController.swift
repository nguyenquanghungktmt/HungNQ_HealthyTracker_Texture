//
//  HomeViewController.swift
//  HungNQ_HealthyTracker_Texture
//
//  Created by Nguyen Quang Hung on 25/07/2022.
//

import AsyncDisplayKit

class HomeViewController : ASDKViewController<ASDisplayNode> {
    lazy var loading        = UIActivityIndicatorView()
    lazy var refreshControl = UIRefreshControl()
    
    var homeNode            = HomeNode()
    
    override init() {
        super.init(node: ASDisplayNode())
        self.node.backgroundColor = .white
        self.node.addSubnode(homeNode)
        self.homeNode.clipsToBounds = true
        self.homeNode.safeArea = self.safeAreaInsets

        self.node.layoutSpecBlock = { [weak self] parentNode, constrainedSize in
            guard let homeNode = self?.homeNode else { return ASLayoutSpec() }

            return ASCenterLayoutSpec(horizontalPosition: .center,
                                                  verticalPosition: .start,
                                                  sizingOption: [],
                                                  child: homeNode)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(loading)
        
        fetchDataNewsFeed()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // Center the activity indicator view
        let bounds = node.bounds
        loading.frame.origin = CGPoint(
            x: (bounds.width - loading.frame.width) / 2.0,
            y: (bounds.height - loading.frame.height) / 2.0
        )
    }
    
    func fetchDataNewsFeed() {
        //load data here
        self.loading.startAnimating()
        APIUtilities.requestHomePatientNewsFeed { [weak self] newsFeedResult, error in
            guard let self = self else { return}
            
            guard let newsFeedResult = newsFeedResult, error == nil else {
                self.loading.stopAnimating()
                self.showToast(message: "Couldn't load data")
                return
            }
            self.homeNode.newsFeed = newsFeedResult

            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                guard let self = self else { return}
                self.homeNode.newsTableNode.reloadData()
                self.loading.stopAnimating()
            }
        }
    }
}
