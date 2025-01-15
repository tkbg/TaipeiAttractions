//
//  ViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/7.
//

import UIKit
import SwiftUI
import SDWebImage

class ViewController: TAViewController {
    
    @IBOutlet weak var taTableView: UITableView!
    
    private var attactionsViewModel = AttractionsViewModel()
    private var newsViewModel = NewsViewModel()
    private var expandStatus: [Bool] = [ false, false]
    private var isShowSwiftUI: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.title = NSLocalizedString("VC_NAVIGATION_HOME_TITLE", comment: "")
        
//        self.showHud()
        
        self.attactionsViewModel.fetchAttractionsList(lang: self.getLang(), page: 1, post: true)
        self.newsViewModel.fetchNewsList(lang: self.getLang(), page: 1, post: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isShowSwiftUI == true {
            
            self.presentSwiftUILaunchScreen()
            isShowSwiftUI = false
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadAttractions), name: Notification.Name("ReloadTable.Attractions"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadNews), name: Notification.Name("ReloadTable.News"), object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver( Notification.Name("ReloadTable.Attractions"))
        NotificationCenter.default.removeObserver( Notification.Name("ReloadTable.News"))
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Check if the user interface style has changed
        if self.traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
            
            self.taTableView.reloadData()
        }
    }
    
    @objc func reloadAttractions() {
        
        if self.newsViewModel.news.count > 0 || self.newsViewModel.total != -1 {
            
            self.hideHud()
        }
        
        self.taTableView.reloadSections(IndexSet(integer: 1), with: .none)
    }
    
    @objc func reloadNews() {
        
        if self.attactionsViewModel.attractions.count > 0  || self.attactionsViewModel.total != -1 {
            
            self.hideHud()
        }
        
        self.taTableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender != nil, let index = sender as? Int {
            
            if segue.identifier ==  "HomeToNew" {
                
                let item = self.newsViewModel.news[index]
                
                if let controller = segue.destination as? NewViewController {
                    
                    controller.newsUrlStr = item.url
                }
            } else if segue.identifier ==  "HomeToAttraction" {
                
                let item = self.attactionsViewModel.attractions[index]
                
                if let controller = segue.destination as? AttractionViewController {
                    
                    controller.attraction = item
                }
            } else if segue.identifier ==  "NewToMore" {
                
                if let controller = segue.destination as? MoreViewController {
                    
                    controller.newsViewModel = self.newsViewModel
                    controller.moreStyle = .NewsStyle
                }
            } else if segue.identifier ==  "AttToMore" {
                
                if let controller = segue.destination as? MoreViewController {
                    
                    controller.attactionsViewModel = self.attactionsViewModel
                    controller.moreStyle = .AttractionsStyle
                }
            }
        }
    }
    
    private func presentSwiftUILaunchScreen() {
        
        let hostingController = UIHostingController(rootView: LaunchScreenView())
        
        present(hostingController, animated: true) {
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                
                hostingController.dismiss(animated: false)
            }
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        if section == 0 {
            
            if self.expandStatus[section] == true {
                
                count = 0
            } else {
                
                count = newsViewModel.news.count
            }
        } else {
            
            if self.expandStatus[section] == true {
                
                count = 0
            } else {
                
                count = attactionsViewModel.attractions.count
            }
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let newCell = tableView.dequeueReusableCell(withIdentifier: "NewCell") as? NewTableViewCell {
                
                let item = newsViewModel.news[indexPath.row]
                
                newCell.titleLabel.text = item.title
                newCell.descriptionLabel.text = item.description
                
                newCell.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
                
                return newCell
            }
        } else {
            
            if let attCell = tableView.dequeueReusableCell(withIdentifier: "AttractionCell") as? AttractionTableViewCell {
                
                let item = attactionsViewModel.attractions[indexPath.row]
                
                attCell.nameLabel.text = item.name
                attCell.introductionLabel.text = item.introduction
                
                if let firstItem: AttImage = item.images.first {
                    
                    if let urlStr = URL(string: firstItem.src) {
                        
                        attCell.attImageView.sd_setImage(with: urlStr)
                    }
                } else {
                    
                    attCell.attImageView.image = UIImage.init(systemName: "mountain.2")
                    attCell.attImageView.tintColor = UIColor(named: "ButtonTintColor")
                }
                
                attCell.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
                
                return attCell
            }
        }
        
        return UITableViewCell()
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            self.performSegue(withIdentifier: "HomeToNew", sender: indexPath.row)
        } else {
            
            self.performSegue(withIdentifier: "HomeToAttraction", sender: indexPath.row)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            guard let newsHeaderView = Bundle.main.loadNibNamed("NewsHeaderView", owner: self ,options: nil)?.first as? NewsHeaderView else {
                return UITableViewHeaderFooterView()
            }
            
            newsHeaderView.titleLabel.text = NSLocalizedString("VC_TABLEVIEW_SECTION_NEWS", comment: "")
            newsHeaderView.pageLabel.text = "\(self.newsViewModel.page) / \(self.newsViewModel.totalPages)"
            
            newsHeaderView.expandButton.tag = 0
            newsHeaderView.expandButton.addTarget(self, action: #selector(expandPressed(_:)), for: .touchUpInside)
            
            newsHeaderView.leftButton.tag = 1
            newsHeaderView.leftButton.addTarget(self, action: #selector(newsPageUporDown(_:)), for: .touchUpInside)
            
            newsHeaderView.rightButton.tag = 0
            newsHeaderView.rightButton.addTarget(self, action: #selector(newsPageUporDown(_:)), for: .touchUpInside)
            
            newsHeaderView.moreButton.tag = 1000
            newsHeaderView.moreButton.addTarget(self, action: #selector(homeToMore(_:)), for: .touchUpInside)
            
            return newsHeaderView
        } else {
            
            guard let attHeaderView = Bundle.main.loadNibNamed("AttractionsHeaderView", owner: self ,options: nil)?.first as? AttractionsHeaderView else {
                return UITableViewHeaderFooterView()
            }
            
            attHeaderView.titleLabel.text = NSLocalizedString("VC_TABLEVIEW_SECTION_ATTRACTION", comment: "")
            attHeaderView.pageLabel.text = "\(self.attactionsViewModel.page) / \(self.attactionsViewModel.totalPages)"
            
            attHeaderView.expandButton.tag = 1
            attHeaderView.expandButton.addTarget(self, action: #selector(expandPressed(_:)), for: .touchUpInside)
            
            attHeaderView.leftButton.tag = 1
            attHeaderView.leftButton.addTarget(self, action: #selector(attPageUporDown(_:)), for: .touchUpInside)
            
            attHeaderView.rightButton.tag = 0
            attHeaderView.rightButton.addTarget(self, action: #selector(attPageUporDown(_:)), for: .touchUpInside)
            
            attHeaderView.moreButton.tag = 2000
            attHeaderView.moreButton.addTarget(self, action: #selector(homeToMore(_:)), for: .touchUpInside)
            
            return attHeaderView
        }
    }
    
    @objc func expandPressed(_ sender: UIButton) {
        
        let tag = sender.tag
        let isExpand = self.expandStatus[tag]
        self.expandStatus[tag] = !isExpand
        
        self.taTableView.reloadSections(IndexSet(integer: tag), with: .none)
    }
    
    @objc func newsPageUporDown(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            if self.newsViewModel.page == self.newsViewModel.totalPages {
                return
            } else {
                
                let count = self.newsViewModel.page + 1
                if count <= self.newsViewModel.totalPages {
                    
                    self.showHud()
                    self.newsViewModel.page = count
                    self.newsViewModel.news.removeAll()
                    self.newsViewModel.fetchNewsList(lang: self.getLang(), page: self.newsViewModel.page, post: true)
                }
            }
        } else {
            
            let count = self.newsViewModel.page - 1
            if count == 0 {
                return
            } else {
                
                if count < self.newsViewModel.totalPages {
                    
                    self.showHud()
                    self.newsViewModel.page = count
                    self.newsViewModel.news.removeAll()
                    self.newsViewModel.fetchNewsList(lang: self.getLang(), page: self.newsViewModel.page, post: true)
                }
            }
        }
    }
    
    @objc func attPageUporDown(_ sender: UIButton) {
        
        if sender.tag == 0 {
            
            if self.attactionsViewModel.page == self.attactionsViewModel.totalPages {
                return
            } else {
                
                let count = self.attactionsViewModel.page + 1
                if count <= self.attactionsViewModel.totalPages {
                    
                    self.showHud()
                    self.attactionsViewModel.page = count
                    self.attactionsViewModel.attractions.removeAll()
                    self.attactionsViewModel.fetchAttractionsList(lang: self.getLang(), page: self.attactionsViewModel.page, post: true)
                }
            }
        } else {
            
            let count = self.attactionsViewModel.page - 1
            if count == 0 {
                return
            } else {
                if count < self.attactionsViewModel.totalPages {
                    
                    self.showHud()
                    self.attactionsViewModel.page = count
                    self.attactionsViewModel.attractions.removeAll()
                    self.attactionsViewModel.fetchAttractionsList(lang: self.getLang(), page: self.attactionsViewModel.page, post: true)
                }
            }
        }
    }
    
    @objc func homeToMore(_ sender: UIButton) {
        
        if sender.tag == 1000 {
            
            self.performSegue(withIdentifier: "NewToMore", sender: sender.tag )
        } else if sender.tag == 2000 {
            
            self.performSegue(withIdentifier: "AttToMore", sender: sender.tag )
        }
    }
}

