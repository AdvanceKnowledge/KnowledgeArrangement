//
//  MyVideoCell.swift
//  KnowledgeArrangement
//
//  Created by 王延磊 on 2023/1/13.
//  Copyright © 2023 ProgrammerHome. All rights reserved.
//

import UIKit
import SDWebImage
import Kingfisher
class MyVideoCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
   
    @IBOutlet weak var descriptionLab: UILabel!
    
    @IBOutlet weak var iv: UIImageView!
//    var model: VideoModel = VideoModel() {
////        didSet {
////            
////            title.text = model.title
////            descriptionLab.text = model.topicName
////            
////            let resource   = ImageResource.init(downloadURL: URL.init(string:model.cover)!)
////            let cache      = KingfisherManager.shared.cache
////            let optionsInfo = [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)),
////                               KingfisherOptionsInfoItem.targetCache(cache),
////                               KingfisherOptionsInfoItem.processor(RoundCornerImageProcessor(cornerRadius: 50))]
////            
////            iv.kf.setImage(with: resource, placeholder: UIImage.init(named: "logo"), options: optionsInfo) { (receivedSize, totalSize) in }
////        completionHandler: { result in }
////        
////        }
//    }
    
    var model: VideoModel = VideoModel() {
        didSet {
            title.text = model.title
            descriptionLab.text = model.topicName
            let resource   = ImageResource.init(name: model.cover, bundle: Bundle.main)
            let optionsInfo = [KingfisherOptionsInfoItem.transition(ImageTransition.fade(1)),
                               KingfisherOptionsInfoItem.targetCache(ImageCache.default),
                               KingfisherOptionsInfoItem.processor(RoundCornerImageProcessor(cornerRadius: 50))]
//            iv.kf.setImage(with: resource)
            iv.sd_setImage(with: URL.init(string: model.cover))
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
