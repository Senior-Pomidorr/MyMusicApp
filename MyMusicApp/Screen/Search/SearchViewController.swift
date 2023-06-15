//
//  SearchViewController.swift
//  MyMusicApp
//
//  Created by Dmitry Medvedev on 13.06.2023.
//

import UIKit
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionTableViews()
    }
    
    private func setupCollectionTableViews() {
        searchView.collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.tableView.register(TableViewCell.self, forCellReuseIdentifier: "TableViewCell")
        searchView.tableView.dataSource = self
        searchView.tableView.delegate = self
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = searchView.collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        cell.configureCell(text: SearchConstant.Text.allCases[indexPath.row].rawValue)
        
        return cell
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 75, height: 36)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        
        cell.configureCellWithSelect()
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? CollectionViewCell else { return }
        
        cell.configureCellWithoutSelect()
    }
}

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = searchView.tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else { return UITableViewCell() }
        
        cell.configureCell(image: UIImage(named: "firstOnboarding") ?? nil, firstText: "Madonna", secondText: "Андрей Малахов")
        cell.separatorInset = UIEdgeInsets(top: 0, left: 80, bottom: 0, right: 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 73
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 21
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top searching"
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SearchViewController {
    private func setupViews() {
        view.backgroundColor = .maBackground
        view.addSubview(searchView.backButton)
        view.addSubview(searchView.searchTextField)
        view.addSubview(searchView.collectionView)
        view.addSubview(searchView.tableView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        searchView.backButton.snp.makeConstraints { make in
            make.centerY.equalTo(searchView.searchTextField)
            make.leading.equalToSuperview().offset(24)
        }
        
        searchView.searchTextField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(8)
            make.trailing.equalToSuperview().offset(-24)
            make.leading.equalTo(searchView.backButton.snp.trailing).offset(12)
        }
    
        searchView.collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.searchTextField.snp.bottom).offset(40)
            make.height.equalTo(50)
        }
        
        searchView.tableView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(searchView.collectionView.snp.bottom).offset(31)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}