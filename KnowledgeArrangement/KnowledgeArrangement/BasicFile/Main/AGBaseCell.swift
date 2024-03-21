//
//  AGBaseCell.swift
//  IOSAgent
//
//  Created by 无名 on 2020/4/15.
//  Copyright © 2020 无名. All rights reserved.
//

import UIKit

class AGBaseCell: UITableViewCell {
    weak var baseViewDelegate: BaseViewDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        createViews()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        createViews()
    }
    
    func createViews() {
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

}
