//
//  DataTableViewCell.swift
//  telstraPOC
//
//  Created by Monarch Bhardwaj on 10/01/19.
//  Copyright © 2019 Monarch Bhardwaj. All rights reserved.
//

import UIKit
import SDWebImage

class DataTableViewCell: UITableViewCell {

    private var dataImageView: UIImageView!
    private var dataTitleLabel: UILabel!
    private var dataDescriptionLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        let imageName = UIImage(named: "defaultImage")
        dataImageView = UIImageView(image: imageName)
        dataImageView.contentMode = .scaleToFill
        dataImageView.translatesAutoresizingMaskIntoConstraints = false
        
        dataTitleLabel = UILabel()
        dataTitleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        dataTitleLabel.numberOfLines = 0
        dataTitleLabel.sizeToFit()
        dataTitleLabel.textColor = UIColor.darkGray
        dataTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        dataDescriptionLabel = UILabel()
        dataDescriptionLabel.numberOfLines = 0
        dataDescriptionLabel.textColor = UIColor.lightGray
        dataDescriptionLabel.sizeToFit()
        dataDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(dataImageView)
        contentView.addSubview(dataTitleLabel)
        contentView.addSubview(dataDescriptionLabel)
        addConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder) has an implementation error!")
    }
    
    func addConstraints(){
        dataTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        dataTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        dataTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        dataImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
        dataImageView.topAnchor.constraint(equalTo: dataTitleLabel.bottomAnchor, constant: 5).isActive = true
        dataImageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        dataImageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        dataImageView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -7).isActive = true
        
        dataDescriptionLabel.topAnchor.constraint(equalTo: dataImageView.topAnchor).isActive = true
        dataDescriptionLabel.leadingAnchor.constraint(equalTo: dataImageView.trailingAnchor, constant: 7).isActive = true
        dataDescriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -5).isActive = true
        dataDescriptionLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -5).isActive = true
    }
    
    func setData(_ dataItem: DataModel){
        self.dataTitleLabel.text = dataItem.rowTitle
        self.dataDescriptionLabel.text = dataItem.rowDescription
        let imageName = UIImage(named: "defaultImage")
        self.dataImageView.sd_setImage(with: dataItem.rowImageURL, placeholderImage: imageName, options: [], progress: nil, completed: nil)
    }
}
