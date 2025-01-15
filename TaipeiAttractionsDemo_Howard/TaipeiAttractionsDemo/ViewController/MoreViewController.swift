//
//  MoreViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit

enum MoreStyle {
    
    case none
    case AttractionsStyle
    case NewsStyle
}

class MoreViewController: TAViewController {
    
    @IBOutlet weak var moreTableView: UITableView!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var pageDownButtonItem: UIBarButtonItem!
    @IBOutlet weak var pageUpButtonItem: UIBarButtonItem!
    
    var attactionsViewModel = AttractionsViewModel()
    var newsViewModel = NewsViewModel()
    var moreStyle: MoreStyle = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        switch self.moreStyle {
        case .AttractionsStyle:
            
            self.title  = NSLocalizedString("VC_TABLEVIEW_SECTION_ATTRACTION", comment: "")
        case .NewsStyle:
            
            self.title = NSLocalizedString("VC_TABLEVIEW_SECTION_NEWS", comment: "")
        case .none:
            
            self.title = ""
        }
        
        self.reNewPageLabel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
            
            self.moreTableView.reloadData()
        }
    }
    
    @objc func reloadAttractions() {
        
        self.hideHud()
        self.moreTableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    @objc func reloadNews() {
        
        self.hideHud()
        self.moreTableView.reloadSections(IndexSet(integer: 0), with: .none)
    }
    
    func reNewPageLabel() -> Void {
        
        if self.moreStyle == .NewsStyle {
            
            self.pageLabel.text = "\(self.newsViewModel.page) / \(self.newsViewModel.totalPages)"
        } else if self.moreStyle == .AttractionsStyle {
            
            self.pageLabel.text = "\(self.attactionsViewModel.page) / \(self.attactionsViewModel.totalPages)"
        }
    }
    
    @IBAction func pageDown(_ sender: Any) {
        
        if self.moreStyle == .NewsStyle {
            
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
        } else if self.moreStyle == .AttractionsStyle {
            
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
        
        self.reNewPageLabel()
    }
    
    @IBAction func pageUp(_ sender: Any) {
        
        if self.moreStyle == .NewsStyle {
            

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
        } else if self.moreStyle == .AttractionsStyle {
            
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
        }
        
        self.reNewPageLabel()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if sender != nil, let index = sender as? Int {
            
            if segue.identifier ==  "MoreToNew" {
                
                let item = self.newsViewModel.news[index]
                
                if let controller = segue.destination as? NewViewController {
                    
                    controller.newsUrlStr = item.url
                }
            } else if segue.identifier ==  "MoreToAttraction" {
                
                let item = self.attactionsViewModel.attractions[index]
                
                if let controller = segue.destination as? AttractionViewController {
                    
                    controller.attraction = item
                }
            }
        }
    }
}

extension MoreViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count = 0
        
        switch self.moreStyle {
        case .AttractionsStyle:
            count = self.attactionsViewModel.attractions.count
        case .NewsStyle:
            count = self.newsViewModel.news.count
        case .none:
            count = 0
        }
        
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.moreStyle == .NewsStyle {
            
            if let newCell = tableView.dequeueReusableCell(withIdentifier: "NewCell") as? NewTableViewCell {
                
                let item = newsViewModel.news[indexPath.row]
                
                newCell.titleLabel.text = item.title
                newCell.descriptionLabel.text = item.description
                
                newCell.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
                
                return newCell
            }
        } else if self.moreStyle == .AttractionsStyle {
            
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
                }
                
                attCell.backgroundBorderView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
                
                return attCell
            }
        }
        
        return UITableViewCell()
    }
}

extension MoreViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch self.moreStyle {
        case .AttractionsStyle:
            
            self.performSegue(withIdentifier: "MoreToAttraction", sender: indexPath.row)
        case .NewsStyle:
            
            self.performSegue(withIdentifier: "MoreToNew", sender: indexPath.row)
        case .none:
            break
        }
    }
}
