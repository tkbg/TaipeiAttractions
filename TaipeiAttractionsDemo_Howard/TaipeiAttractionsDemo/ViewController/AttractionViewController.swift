//
//  AttractionViewController.swift
//  TaipeiAttractionsDemo
//
//  Created by HowardHung on 2025/1/10.
//

import UIKit

class AttractionViewController: TAViewController {
    
    var attraction: Attraction?
    private var canShowItems: [[String: String]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canShowItems.removeAll()
        
        if let item = self.attraction {
            
            self.title = item.name
            
            if item.images.count > 0 {
                
                let show = ["key": "images", "style": "AttImageTableViewCell"]
                self.canShowItems.append(show)
            }
            
            if let openTime = item.open_time, openTime.count > 0 {
                
                let show = ["key": "openTime", "style": "AttLabelTableViewCell"]
                self.canShowItems.append(show)
            }
            
            if let address = item.address, address.count > 0 {
                
                let show = ["key": "address", "style": "AttLabelTableViewCell"]
                self.canShowItems.append(show)
            }
            
            if let tel = item.tel, tel.count > 0 {
                
                let show = ["key": "tel", "style": "AttLabelTableViewCell"]
                self.canShowItems.append(show)
            }
            
            if let url = item.url, url.count > 0 {
                
                let show = ["key": "url", "style": "AttLabelTableViewCell"]
                self.canShowItems.append(show)
            }
            
            if let introduction = item.introduction, introduction.count > 0 {
                
                let show = ["key": "introduction", "style": "AttLabelTableViewCell"]
                self.canShowItems.append(show)
            }
        }
    }
}

extension AttractionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.canShowItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let itemDic = self.canShowItems[indexPath.row]
        let key = itemDic["key"]
        
        if key == "images" {
            
            if let imageTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AttImageTableViewCell") as? AttImageTableViewCell {
                
                if let item = self.attraction {
                    
                    if let firstItem: AttImage = item.images.first {
                        
                        if let urlStr = URL(string: firstItem.src) {
                            
                            imageTableViewCell.attImageView.sd_setImage(with: urlStr)
                        }
                    } else {
                        
                        imageTableViewCell.attImageView.image = UIImage.init(systemName: "mountain.2")
                    }
                }
                
                return imageTableViewCell
            }
        } else if key == "openTime" ||
                    key == "address" ||
                    key == "tel" ||
                    key == "url" {
            
            if let labelTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AttLabelTableViewCell") as? AttLabelTableViewCell {
                
                labelTableViewCell.selectionStyle = .none
                if let item = self.attraction {
                    
                    switch key {
                    case "openTime" :
                        labelTableViewCell.attLabel.text = NSLocalizedString("ATTRACTION_OPEN_TIME", comment: "") + " :\(item.open_time!)"
                    case "address":
                        labelTableViewCell.attLabel.text = NSLocalizedString("ATTRACTION_ADDRESS", comment: "") + " :\(item.address!)"
                    case "tel":
                        labelTableViewCell.selectionStyle = .blue
                        labelTableViewCell.attLabel.text = NSLocalizedString("ATTRACTION_TELEPHONE", comment: "") + " :\(item.tel!)"
                    case "url":
                        labelTableViewCell.selectionStyle = .blue
                        labelTableViewCell.attLabel.text = NSLocalizedString("ATTRACTION_TELPHONE", comment: "") + " :\(item.url!)"
                    default:
                        labelTableViewCell.attLabel.text = ""
                    }
                } else {
                    
                    labelTableViewCell.attLabel.text = ""
                }

                return labelTableViewCell
            }
        } else if key == "introduction" {
            
            if let textTableViewCell = tableView.dequeueReusableCell(withIdentifier: "AttTextTableViewCell") as? AttTextTableViewCell {
                
                if let item = self.attraction {
                    
                    textTableViewCell.attTextView.text = item.introduction
                } else {
                    
                    textTableViewCell.attTextView.text = ""
                }

                return textTableViewCell
            }
        }
        
        return UITableViewCell()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let item = self.attraction, let urlstr = item.url {
            
            if let controller = segue.destination as? AttractionWebViewController {
                
                controller.attTitleStr = item.name
                controller.attUrlStr = urlstr
            }
        }
    }
}

extension AttractionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let itemDic = self.canShowItems[indexPath.row]
        let key = itemDic["key"]
        
        if key == "images" {
            
            return 200
        } else if key == "openTime" ||
                    key == "address" ||
                    key == "tel" ||
                    key == "url" {
            
            return UITableView.automaticDimension
        } else if key == "introduction" {
            
            return 300
        }
        
        return 44
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let itemDic = self.canShowItems[indexPath.row]
        if let key = itemDic["key"] {
            
            if key == "tel" {
                
                if let item = self.attraction {
                    
                    let telUrl = URL(string: "tel://\(item.tel!)")
                    if UIApplication.shared.canOpenURL(telUrl!) {
                        
                        UIApplication.shared.open(telUrl!, options: [:]) { success in
                            
                        }
                    }
                }
            } else if key == "url" {
                
                self.performSegue(withIdentifier: "AttToWeb", sender: nil)
            }
        }
    }
}
