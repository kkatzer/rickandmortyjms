//
//  ShowCharacterViewCell.swift
//  Rick and Morty
//
//  Created by Kevin Katzer on 03/09/20.
//  Copyright © 2020 kkatzer. All rights reserved.
//

import UIKit

class ShowCharacterViewCell: UITableViewCell {
    
    lazy var title: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "Black")
        view.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return view
    }()
    
    lazy var subtitle: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "Gray 1")
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }()
    
    lazy var date: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.textColor = UIColor(named: "Gray 1")
        view.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupEpisode() {
        self.selectionStyle = .none
        addSubview(title)
        addSubview(subtitle)
        addSubview(date)
        
//        title.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(16)
//            make.top.equalToSuperview().inset(9)
//        }
//
//        subtitle.snp.makeConstraints { make in
//            make.left.equalTo(title)
//            make.top.equalTo(title.snp.bottom)
//        }
//
//        date.snp.makeConstraints { make in
//            make.left.equalTo(title)
//            make.top.equalTo(subtitle.snp.bottom)
//            make.bottom.equalToSuperview().inset(12)
//        }
    }
    
    func setupInformations() {
        addSubview(title)
        addSubview(subtitle)
        
//        title.snp.makeConstraints { make in
//            make.left.equalToSuperview().inset(16)
//            make.top.equalToSuperview().inset(9)
//        }
//        
//        subtitle.snp.makeConstraints { make in
//            make.left.equalTo(title)
//            make.top.equalTo(title.snp.bottom)
//            make.bottom.equalToSuperview().inset(12)
//        }
    }

}
