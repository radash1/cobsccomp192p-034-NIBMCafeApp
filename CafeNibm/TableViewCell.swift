//
//  TableViewCell.swift
//  CafeNibm
//
//  Created by Ravindu Liyanage on 3/8/21.
//  Copyright © 2021 Ravindu Liyanage. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var nameC = UILabel()
    var priceC = UILabel()
    var picC = UIImageView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameC)
        addSubview(priceC)
        addSubview(picC)
        
        configname()
        configprice()
        configpic()
        setnamecon()
        setpricecon()
        setpiccon()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(tab : Tab){
        
        nameC.text = tab.name
        priceC.text = " Rs.\(tab.price)"
        
        guard let url = URL(string: tab.pic) else {
            
            return
        }
        let getDataTask = URLSession.shared.dataTask(with: url){ data, _, error in
            
            guard let data = data, error == nil else{
                    return
                }
            
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.picC.image = image
            
            }
        }
        getDataTask.resume()
    
        
    }
    
    func configname(){
        
        nameC.adjustsFontSizeToFitWidth = true
        nameC.numberOfLines = 0
        
    }
    
    func configprice(){
        
        priceC.adjustsFontSizeToFitWidth = true
        priceC.numberOfLines = 0
        
    }
    
    func configpic(){
        
        picC.clipsToBounds = true
        
    }
    
    func setnamecon(){
         
        nameC.translatesAutoresizingMaskIntoConstraints = false
        nameC.centerYAnchor.constraint(equalTo : centerYAnchor , constant: -10).isActive = true
        nameC.leadingAnchor.constraint(equalTo: picC.trailingAnchor, constant: 20).isActive = true
        nameC.heightAnchor.constraint(equalToConstant: 80).isActive = true
        nameC.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        
        
    }
    func setpricecon(){
        
        priceC.translatesAutoresizingMaskIntoConstraints = false
        priceC.centerYAnchor.constraint(equalTo : nameC.bottomAnchor , constant: -10).isActive = true
        priceC.leadingAnchor.constraint(equalTo: picC.trailingAnchor, constant: 20).isActive = true
        priceC.heightAnchor.constraint(equalToConstant: 80).isActive = true
        priceC.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
    }
    func setpiccon(){
        
        picC.translatesAutoresizingMaskIntoConstraints = false
        picC.centerYAnchor.constraint(equalTo : centerYAnchor).isActive = true
        picC.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        picC.heightAnchor.constraint(equalToConstant: 150).isActive = true
        picC.widthAnchor.constraint(equalTo: picC.heightAnchor, multiplier: 1.5).isActive = true
        
    }
}
