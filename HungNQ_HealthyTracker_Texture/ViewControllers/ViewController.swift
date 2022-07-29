//
//  ViewController.swift
//  DemoTexture
//
//  Created by Nguyen Quang Hung on 18/07/2022.
//

import AsyncDisplayKit

class ViewController: ASDKViewController<ASDisplayNode> {
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        return UIActivityIndicatorView(style: .gray)
    }()
    
    var demoNode = NewsFeedCell()
    
    override init() {
        super.init(node: BaseNode())
        self.node.backgroundColor = .lightGray
        
        
        self.node.addSubnode(demoNode)

        self.node.layoutSpecBlock = { [weak self] parentNode, constrainedSize in
            guard let customNode = self?.demoNode else { return ASLayoutSpec() }
            customNode.clipsToBounds = true
            let layoutSpec = ASRelativeLayoutSpec(horizontalPosition: .center,
                                                  verticalPosition: .end,
                                                  sizingOption: [],
                                                  child: customNode)
            
            return layoutSpec
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationController?.hidesBarsOnSwipe = true
        
        node.view.addSubview(activityIndicatorView)
        
        self.demoNode.isHidden = true
        self.activityIndicatorView.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.activityIndicatorView.stopAnimating()
            self.demoNode.isHidden = false
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
        // Center the activity indicator view
        let bounds = node.bounds
        activityIndicatorView.frame.origin = CGPoint(
            x: (bounds.width - activityIndicatorView.frame.width) / 2.0,
            y: (bounds.height - activityIndicatorView.frame.height) / 2.0
        )
        
        
    }
    
    


}

