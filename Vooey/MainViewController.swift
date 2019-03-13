//
//  MainViewController.swift
//  Vooey
//
//  Created by Blake Tsuzaki on 3/7/19.
//  Copyright © 2019 Modoki. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    private let toolbarView = ToolbarView()
    private let brandingBar = UIImageView(named: "BrandingBar")
    private let backButton = UIImageView(named: "BackButton")
    private let mainContainer = UIView()
    private let ftuiView = FTUIView()
    private let homeView = HomeView()
    private let quoteView = QuoteDeepView()
    private let tipCardView = TipCardView()
    private let settingsView = SettingsView()
    private let transcriptView = TranscriptView()
    private let yourWordsView = TranscriptView()
    private let vooeyView = VooeyView()
    private let dataView = DataView()
    
    private var quoteViewTopConstraint: NSLayoutConstraint?
    private var homeViewTopConstraint: NSLayoutConstraint?
    private var tipCardViewTopConstraint: NSLayoutConstraint?
    private var mainContainerHorizontalConstraint: NSLayoutConstraint?
    private var mainContainerVerticalConstraint: NSLayoutConstraint?
    private var transcriptViewTopConstraint: NSLayoutConstraint?
    private var yourWordsViewTopConstraint: NSLayoutConstraint?
    private var toolbarViewVerticalConstraint: NSLayoutConstraint?
    private var ftuiViewVerticalConstraint: NSLayoutConstraint?
    private var state: AppState = .active {
        didSet {
            if state == oldValue { return }
            
            switch state {
            case .ftui:
                mainContainer.isHidden = true
                ftuiView.isHidden = false
                toolbarView.type = .nofab
            case .empty:
                mainContainer.isHidden = false
                mainContainer.alpha = 0
                
                let newConstraint = mainContainer.top(equalTo: toolbarView, attribute: .bottom)
                replace(&mainContainerVerticalConstraint, with: newConstraint)
                view.layoutIfNeeded()
                
                UIView.animate(withDuration: 0.5,
                               animations: {
                                let newConstraint = self.ftuiView.top(equalTo: self.toolbarView)
                                self.replace(&self.ftuiViewVerticalConstraint, with: newConstraint)
                                self.view.layoutIfNeeded()
                                self.ftuiView.alpha = 0
                }) { (_) in
                    UIView.animate(withDuration: 0.5, animations: {
                        let newConstraint = self.mainContainer.top(equalTo: self.brandingBar,
                                                              attribute: .bottom,
                                                              spacing: -40)
                        self.replace(&self.mainContainerVerticalConstraint, with: newConstraint)
                        self.view.layoutIfNeeded()
                        self.mainContainer.alpha = 1
                    }, completion: { (_) in
                        self.ftuiView.isHidden = true
                        self.ftuiView.alpha = 1
                    })
                    
                    UIView.animate(withDuration: 0.2,
                                   animations: {
                                    let newConstraint = self.toolbarView.top(equalTo: self.view, attribute: .bottom)
                                    self.replace(&self.toolbarViewVerticalConstraint, with: newConstraint)
                                    self.view.layoutIfNeeded()
                    }) { (_) in
                        self.toolbarView.type = .fab
                        UIView.animate(withDuration: 0.2,
                                       animations: {
                                        let newConstraint = self.toolbarView.bottom(equalTo: 4)
                                        self.replace(&self.toolbarViewVerticalConstraint, with: newConstraint)
                                        self.view.layoutIfNeeded()
                        })
                    }
                }
                homeView.useEmptyState = true
                dataView.useEmptyState = true
                settingsView.useEmptyState = true
            case .active:
//                mainContainer.isHidden = false
                toolbarView.type = .fab
                
                homeView.useEmptyState = false
                dataView.useEmptyState = false
                settingsView.useEmptyState = false
            }
        }
    }
    
    private let backButtonTarget = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let views = [brandingBar,
                     backButton,
                     backButtonTarget,
                     vooeyView,
                     mainContainer,
                     ftuiView,
                     toolbarView]
        
        let pages = [homeView,
                     quoteView,
                     tipCardView,
                     settingsView,
                     transcriptView,
                     yourWordsView,
                     dataView]
        
        view.addSubviews(views)
        mainContainer.addSubviews(pages)
        
        let mainContainerHorizontalConstraint = mainContainer.left()
        self.mainContainerHorizontalConstraint = mainContainerHorizontalConstraint
        
        let mainContainerVerticalConstraint = mainContainer.top(equalTo: brandingBar,
                                                                attribute: .bottom,
                                                                spacing: -40)
        self.mainContainerVerticalConstraint = mainContainerVerticalConstraint
        
        let quoteViewTopConstraint = quoteView.top()
        self.quoteViewTopConstraint = quoteViewTopConstraint
        
        let homeViewTopConstraint = homeView.top()
        self.homeViewTopConstraint = homeViewTopConstraint
        
        let tipCardViewTopConstraint = tipCardView.top()
        self.tipCardViewTopConstraint = tipCardViewTopConstraint
        
        let transcriptViewTopConstraint = transcriptView.top()
        self.transcriptViewTopConstraint = transcriptViewTopConstraint
        
        let yourWordsViewTopConstraint = yourWordsView.top()
        self.yourWordsViewTopConstraint = yourWordsViewTopConstraint
        
        let toolbarViewVerticalConstraint = toolbarView.bottom(equalTo: 4)
        self.toolbarViewVerticalConstraint = toolbarViewVerticalConstraint
        
        let ftuiViewVerticalConstraint = ftuiView.top(equalTo: brandingBar,
                                                      attribute: .bottom,
                                                      spacing: -40)
        self.ftuiViewVerticalConstraint = ftuiViewVerticalConstraint
        
        let constraints = [
            toolbarView.left(equalTo: -3),
            toolbarView.right(equalTo: 3),
            toolbarViewVerticalConstraint,
            toolbarView.height(equalTo: 100),
            
            brandingBar.left(),
            brandingBar.right(),
            brandingBar.top(),
            brandingBar.equalHeightWidth(multiplier: 302 / 824),
            
            backButton.equalHeightWidth(multiplier: 40 / 24),
            backButton.height(equalTo: 18),
            backButton.left(equalTo: 14),
            backButton.top(equalTo: 40),
            
            backButtonTarget.height(equalTo: brandingBar),
            backButtonTarget.equalHeightWidth(),
            backButtonTarget.left(),
            backButtonTarget.top(),
            
            quoteView.left(),
            quoteView.width(equalTo: view),
            quoteViewTopConstraint,
            quoteView.bottom(equalTo: toolbarView, attribute: .top),
            
            tipCardView.left(),
            tipCardView.width(equalTo: view),
            tipCardViewTopConstraint,
            tipCardView.bottom(equalTo: toolbarView, attribute: .top),
            
            mainContainer.height(equalTo: view),
            mainContainer.width(equalTo: view, multiplier: 3),
            mainContainerVerticalConstraint,
            mainContainerHorizontalConstraint,

            homeView.left(),
            homeView.width(equalTo: view),
            homeViewTopConstraint,
            homeView.bottom(equalTo: toolbarView, attribute: .top),
            
            dataView.centerX(),
            dataView.width(equalTo: view),
            dataView.top(),
            dataView.bottom(equalTo: toolbarView, attribute: .top),
            
            settingsView.right(),
            settingsView.width(equalTo: view),
            settingsView.top(),
            settingsView.bottom(equalTo: toolbarView, attribute: .top),
            
            yourWordsView.centerX(),
            yourWordsView.width(equalTo: view),
            yourWordsViewTopConstraint,
            yourWordsView.bottom(equalTo: toolbarView, attribute: .top),
            
            transcriptView.right(),
            transcriptView.width(equalTo: view),
            transcriptViewTopConstraint,
            transcriptView.bottom(equalTo: toolbarView, attribute: .top),
            
            vooeyView.left(),
            vooeyView.right(),
            vooeyView.top(equalTo: brandingBar, attribute: .bottom, spacing: 40),
            vooeyView.bottom(equalTo: toolbarView, attribute: .top),
            
            ftuiView.left(),
            ftuiView.right(),
            ftuiViewVerticalConstraint,
            ftuiView.bottom(equalTo: toolbarView, attribute: .top),
        ]
        
        view.activate(views: views + pages, constraints: constraints)
        view.backgroundColor = .white
        
        quoteView.isHidden = true
        tipCardView.isHidden = true
        transcriptView.isHidden = true
        yourWordsView.isHidden = true
        
        homeView.tapDelegate = self
        settingsView.tapDelegate = self
        transcriptView.tapDelegate = self
        toolbarView.delegate = self
        dataView.tapDelegate = self
        ftuiView.tapDelegate = self
        
        transcriptView.delegate = self
        transcriptView.hideDeleteButton = false
        
        homeView.delegate = self
        dataView.delegate = self
        settingsView.delegate = self
        quoteView.delegate = self
        tipCardView.delegate = self
        
        backButtonTarget.addTarget(self,
                                   action: #selector(MainViewController.handleGoBack),
                                   for: .touchUpInside)
        backButton.isHidden = true
        
        vooeyView.isHidden = true
        
        PubNubCoordinator.shared.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        state = .ftui
    }
    
    @objc func handleGoBack() {
        homeView.alpha = 0
        homeView.isHidden = false
        settingsView.alpha = 0
        settingsView.isHidden = false
        dataView.alpha = 0
        dataView.isHidden = false
        mainContainer.alpha = 1
        mainContainer.isHidden = false
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.homeView.alpha = 1
                        self.settingsView.alpha = 1
                        self.dataView.alpha = 1
                        self.quoteView.alpha = 0
                        self.tipCardView.alpha = 0
                        self.transcriptView.alpha = 0
                        self.yourWordsView.alpha = 0
                        let newConstraint = self.mainContainer.top(equalTo: self.brandingBar,
                                                              attribute: .bottom,
                                                              spacing: -40)
                        self.view.replace(&self.mainContainerVerticalConstraint, with: newConstraint)
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(0)
        }) { (_) in
            self.quoteView.isHidden = true
            self.quoteView.contentOffset = CGPoint()
            self.tipCardView.isHidden = true
            self.tipCardView.contentOffset = CGPoint()
            self.transcriptView.isHidden = true
            self.transcriptView.contentOffset = CGPoint()
            self.yourWordsView.isHidden = true
            self.yourWordsView.contentOffset = CGPoint()
            
            self.backButton.isHidden = true
            self.vooeyView.isHidden = true
            
        }
        
        self.toolbarView.keyFabEnabled = false
    }
    
    func resetState() {
        self.homeView.isHidden = false
        self.homeView.alpha = 1
        self.settingsView.isHidden = false
        self.settingsView.alpha = 1
        
        self.quoteView.isHidden = true
        self.quoteView.contentOffset = CGPoint()
        self.tipCardView.isHidden = true
        self.tipCardView.contentOffset = CGPoint()
        self.transcriptView.isHidden = true
        self.transcriptView.contentOffset = CGPoint()
        self.yourWordsView.isHidden = true
        self.yourWordsView.contentOffset = CGPoint()
        
        self.backButton.isHidden = true
        self.toolbarView.keyFabEnabled = false
    }
}

extension MainViewController: ToolbarViewDelegate {
    func showView(_ view: VooeySection) {
        var newConstraint: NSLayoutConstraint?
        
        switch view {
        case .home:
            newConstraint = mainContainer.left()
        case .data:
            newConstraint = mainContainer.centerX()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.dataView.addBubbles()
            }
        case .settings:
            newConstraint = mainContainer.right()
        }
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.replace(&self.mainContainerHorizontalConstraint, with: newConstraint!)
            self.view.layoutIfNeeded()
            self.toolbarView.updateForOffset(0)
        }) { (_) in
            self.resetState()
        }
    }
    
    func fabTapped() {
        vooeyView.alpha = 0
        vooeyView.isHidden = false
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                        let newConstraint = self.mainContainer.top(equalTo: self.toolbarView,
                                                                   attribute: .bottom,
                                                                   spacing: 0)
                        self.view.replace(&self.mainContainerVerticalConstraint, with: newConstraint)
                        
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(1000)
                        self.mainContainer.alpha = 0
        }) { (_) in
            self.mainContainer.alpha = 1
            self.mainContainer.isHidden = true
            self.backButton.isHidden = false
            
            UIView.animate(withDuration: 0.5, animations: {
                self.vooeyView.alpha = 1
            }) { (_) in
                self.toolbarView.keyFabEnabled = true
            }
        }
    }
    
    func keyTapped() {
        let alert = UIAlertController(title: "Unsupported",
                                      message: "Unfortunately, keyboard input is not supported by Vooey at this time.",
                                      preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func speechTapped() {
        vooeyView.speechEnabled = !vooeyView.speechEnabled
    }
}

extension MainViewController: HomeViewDelegate {
    func handleQuoteTapped(frame: CGRect) {
        let tempView = UIImageView(named: "QuoteCardBlank")
        let textView = UIImageView(named: "QuoteText")
        let textWidth = frame.width - 54
        
        tempView.frame = frame
        textView.frame = CGRect(x: 25, y: 112, width: textWidth, height: textWidth * 100 / 680)
        
        view.addSubview(tempView)
        tempView.addSubview(textView)
        
        quoteView.alpha = 0
        quoteView.isHidden = false
        
        view.replace(&quoteViewTopConstraint, with: quoteView.top(equalTo: brandingBar, attribute: .bottom, spacing: 100))
        
        view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.5,
                       animations: {
                        tempView.frame.size.height = 90
                        textView.frame.origin.y = 30

                        self.homeView.alpha = 0
                        self.homeView.topCardHidden = true
                        self.quoteView.alpha = 1

                        let newQuoteConstraint = self.quoteView.top()
                        let newHomeConstraint = self.homeView.top(equalTo: self.brandingBar,
                                                                  attribute: .bottom,
                                                                  spacing: -200)
                        
                        self.view.replace(&self.quoteViewTopConstraint,
                                          with: newQuoteConstraint)
                        self.view.replace(&self.homeViewTopConstraint,
                                          with: newHomeConstraint)
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(0)
        }) { (_) in
            tempView.removeFromSuperview()
            self.homeView.isHidden = true
            self.homeView.topCardHidden = false
            self.view.replace(&self.homeViewTopConstraint,
                              with: self.homeView.top())
            self.view.layoutIfNeeded()
            
            self.backButton.isHidden = false
        }
    }
    
    func handleTipTapped() {
        tipCardView.alpha = 0
        tipCardView.isHidden = false
        
        view.replace(&tipCardViewTopConstraint, with: tipCardView.top(equalTo: toolbarView, attribute: .bottom, spacing: 0))
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.tipCardView.alpha = 1
                        self.homeView.alpha = 0
                        
                        let newConstraint = self.tipCardView.top()
                        
                        self.view.replace(&self.tipCardViewTopConstraint, with: newConstraint)
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(0)
        }) { (_) in
            self.homeView.isHidden = true
            self.backButton.isHidden = false
        }
    }
}

extension MainViewController: SettingsViewDelegate {
    func tappedTranscript() {
        transcriptView.alpha = 0
        transcriptView.isHidden = false
        
        view.replace(&transcriptViewTopConstraint, with: transcriptView.top(equalTo: toolbarView, attribute: .top, spacing: 0))
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.transcriptView.alpha = 1
                        self.settingsView.alpha = 0
                        
                        let newConstraint = self.transcriptView.top()
                        
                        self.view.replace(&self.transcriptViewTopConstraint, with: newConstraint)
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(0)
        }) { (_) in
            self.settingsView.isHidden = true
            self.backButton.isHidden = false
        }
    }
}

extension MainViewController: DataViewDelegate {
    func transcriptTapped() {
        yourWordsView.alpha = 0
        yourWordsView.isHidden = false
        
        view.replace(&yourWordsViewTopConstraint, with: yourWordsView.top(equalTo: toolbarView, attribute: .top, spacing: 0))
        view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5,
                       animations: {
                        self.yourWordsView.alpha = 1
                        self.dataView.alpha = 0
                        
                        let newConstraint = self.yourWordsView.top()
                        
                        self.view.replace(&self.yourWordsViewTopConstraint, with: newConstraint)
                        self.view.layoutIfNeeded()
                        self.toolbarView.updateForOffset(0)
        }) { (_) in
            self.dataView.isHidden = true
            self.backButton.isHidden = false
        }
    }
}

extension MainViewController: TranscriptViewDelegate {
    func deleteItem() {
        let alert = UIAlertController(title: "Are you sure?",
                                      message: "The more information we collect the more personalized our recommendations are",
                                      preferredStyle: .alert)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive, handler: { (_) in
            self.handleGoBack()
        })
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: FTUIViewDelegate {
    func exitFtui() {
        state = .empty
    }
}

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        toolbarView.updateForOffset(scrollView.contentOffset.y)
    }
}

extension MainViewController: PubNubDelegate {
    func receivedTerms(_ terms: [String]) {
        dataView.data = terms
    }
    
    func needsState(_ state: AppState) {
        self.state = state
    }
}
