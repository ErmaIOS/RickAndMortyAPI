//
//  CharacterCell.swift
//  RickAndMortyAPI
//
//  Created by Erma on 8/7/24.
//

import UIKit
import SnapKit

class CharacterCell: UITableViewCell {
    static let reusd = "characterCell"
    private let imageCharacter: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameCharacter: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        contentView.addSubview(imageCharacter)
        contentView.addSubview(nameCharacter)
        
        imageCharacter.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.height.equalTo(50)
            make.centerY.equalToSuperview()
        }
        nameCharacter.snp.makeConstraints { make in
            make.centerY.equalTo(imageCharacter.snp.centerY)
            make.leading.equalTo(imageCharacter.snp.trailing).offset(16)
            make.centerY.equalToSuperview()       
        }
    }
    
    func fill(with model: APIResponseResults) {
        nameCharacter.text = model.name
        if let url = URL(string: model.image) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageCharacter.image = UIImage(data: data)
                    }
                }
            }.resume()
        }
    }
}

