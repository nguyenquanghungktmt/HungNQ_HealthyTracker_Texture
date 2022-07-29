//
//  ButtonPresentation.swift
//  DemoTexture
//
//  Created by Nguyen Quang Hung on 21/07/2022.
//

import AsyncDisplayKit

class ButtonNode : ASDisplayNode {
    let btnLogin    = ASButtonNode()
    let btnRegister = ASButtonNode()
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
//        automaticallyRelayoutOnSafeAreaChanges = false
        backgroundColor = .white
        
        initViews()
    }
    
    func initViews() {
        btnLogin.setTitle("Đăng nhập", with: .systemFont(ofSize: 15), with: .white, for: .normal)
        btnRegister.setTitle("Tạo tài khoản", with: .systemFont(ofSize: 15), with: .black, for: .normal)
        
        btnLogin.backgroundColor = Constants.Color.greenBold
        btnLogin.cornerRadius = 24
        
        btnRegister.backgroundColor = .white
        btnRegister.cornerRadius = 24
        btnRegister.borderColor = UIColor.black.cgColor
        btnRegister.borderWidth = 1
        
        
        btnLogin.addTarget(self, action: #selector(buttonPressed), forControlEvents: .touchUpInside)
        btnRegister.addTarget(self, action: #selector(buttonPressed), forControlEvents: .touchUpInside)
        
        btnLogin.contentVerticalAlignment = .center
        btnLogin.contentHorizontalAlignment = .middle
        
        btnRegister.contentVerticalAlignment = .center
        btnRegister.contentHorizontalAlignment = .middle
        
        btnLogin.clipsToBounds = true
        btnRegister.clipsToBounds = true
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let viewBtnLogin = ASWrapperLayoutSpec(layoutElement: btnLogin)
        let viewBtnRegister = ASWrapperLayoutSpec(layoutElement: btnRegister)
        viewBtnLogin.style.height = ASDimensionMake(48)
        viewBtnRegister.style.height = ASDimensionMake(48)
        
        let btnLoginInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 0), child: viewBtnLogin)
        let btnRegisterInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16), child: viewBtnRegister)
        
        
        let buttonStack = ASStackLayoutSpec(direction: .horizontal,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [btnLoginInset, btnRegisterInset])
        
        buttonStack.style.height = ASDimensionMake(80)
        buttonStack.style.width = ASDimensionMake(constrainedSize.max.width)
        btnLoginInset.style.flexBasis = ASDimensionMakeWithFraction(166/375)
        btnRegisterInset.style.flexBasis = ASDimensionMakeWithFraction(209/375)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0), child: buttonStack)
    }
    
    @objc
    func buttonPressed() {
        print("tapped at button")
    }
}
