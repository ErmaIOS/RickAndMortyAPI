//
//  DetailViewController.swift
//  RickAndMortyAPI
//
//  Created by Erma on 8/7/24.
//

import UIKit

class DetailViewController: UIViewController {
    
    private let imageCharacter: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        return image
    }()
        
    private let statusCharacter: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private let networkLayer = NetworkLayer()
    var character: APIResponseResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
        view.backgroundColor = .white
        if let character = self.character {
                fill(with: character)
            }
    }
    
    private func setupConstraints() {
        view.addSubview(imageCharacter)
        view.addSubview(statusCharacter)
        
        imageCharacter.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(16)
            make.height.equalTo(300)
        }
        statusCharacter.snp.makeConstraints { make in
            make.top.equalTo(imageCharacter.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
   
      
    private func fill(with model: APIResponseResults) {
        if let url = URL(string: model.image) {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data {
                        DispatchQueue.main.async {
                            self.imageCharacter.image = UIImage(data: data)
                        }
                    }
                }.resume()
            }
        statusCharacter.text = model.status
        paintingStatus(with: model)
    }
    
    private func paintingStatus(with model: APIResponseResults) {
        if model.status == "Alive"{
            statusCharacter.textColor = .green
        }else if model.status == "Dead"{
            statusCharacter.textColor = .red
        }else if model.status == "unknown" {
            statusCharacter.textColor = .blue
        }
    }
}

