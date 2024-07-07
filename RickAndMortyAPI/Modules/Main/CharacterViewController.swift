//
//  CharacterViewController.swift
//  RickAndMortyAPI
//
//  Created by Erma on 8/7/24.
//

import UIKit
import SnapKit

class CharacterViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private var characters: [APIResponseResults] = []
    private let networkLayer = NetworkLayer()
    var character: APIResponseResults?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(tableView)
        setTableView()
        setupConstraints()
        fetchCharacters()
    }
    
    private func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterCell.self, forCellReuseIdentifier: CharacterCell.reusd)
    }
    
    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    private func fetchCharacters() {
        networkLayer.fetchCharacters() { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let characters):
                DispatchQueue.main.async {
                    self.characters = characters
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterCell.reusd, for: indexPath) as! CharacterCell
        let character = characters[indexPath.row]
        cell.fill(with: character)
        return cell
    }
}
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedCharacter = characters[indexPath.row]
        let vc = DetailViewController()
        vc.character = selectedCharacter
        navigationController?.pushViewController(vc, animated: true)
    }
}

