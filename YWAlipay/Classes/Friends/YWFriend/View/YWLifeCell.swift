//
//  YWLifeCell.swift
//  支付宝生活界面
//
//  Created by Mac on 2017/6/15.
//  Copyright © 2017年 Mac. All rights reserved.
//

import UIKit

class YWLifeCell: UITableViewCell {

    @IBOutlet var headImage: UIImageView!
    @IBOutlet var contentImage: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var dayLabel: UILabel!
    @IBOutlet var deleteLabel: UILabel!
    @IBOutlet var moreBtn: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK: - 界面
    private func setupUI() {
        contentImage.snp_makeConstraints { (make) in
            make.top.equalTo(contentLabel.snp_bottom).offset(8)
            make.left.equalTo(nameLabel.snp_left)
            make.width.height.equalTo(0)
        }
        
        dayLabel.snp_makeConstraints { (make) in
            make.top.equalTo(contentImage.snp_bottom).offset(8)
            make.left.equalTo(nameLabel.snp_left)
        }
        
        deleteLabel.snp_makeConstraints { (make) in
            make.left.equalTo(dayLabel.snp_right).offset(8)
            make.centerY.equalTo(dayLabel.snp_centerY)
        }
        
        moreBtn.snp_makeConstraints { (make) in
            make.right.equalTo(-8)
            make.top.equalTo(deleteLabel.snp_top)
            make.bottom.equalTo(-8)
        }
    
    }
    
    //MARK: - data
    func setModel(model: YWLifeModel) {
        headImage.image = UIImage(named: model.icon)
        nameLabel.text = model.name
        contentLabel.text = model.content
        if model.picture != nil {
            contentImage.image = UIImage(named: model.picture)
            let width = 150/self.contentImage.image!.size.height * self.contentImage.image!.size.width
            
            contentImage.snp_updateConstraints(closure: { (make) in
                make.width.equalTo(width)
                make.height.equalTo(150)
            })
        }
        dayLabel.text = model.time
        if model.isMine == 1 {
            deleteLabel.hidden = true
        }else{
            deleteLabel.hidden = false
        }
    }
    
    
}
