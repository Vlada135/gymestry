//
//  DirectoryController.swift
//  Gymestry
//
//  Created by Владислава on 11.09.23.
//

import Foundation
import SnapKit
import UIKit

class DirectoryController: UIViewController {
    var data: [[Directory]] = []

    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.dataSource = self
        table.delegate = self
        table.register(DirectoryCell.self, forCellReuseIdentifier: DirectoryCell.id)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeLayout()
        makeConstraints()
    }
    private func makeLayout() {
        view.addSubview(tableView)
        view.backgroundColor = .white
    }
        private func makeConstraints() {
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
    
extension DirectoryController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int  {
        return data.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let point = data[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: DirectoryCell.id, for: indexPath)
        guard let categorycell = cell as? DirectoryCell else { return .init() }
        categorycell.set(point: point)
        return categorycell
    }
}

extension DirectoryController: UITableViewDelegate {
    }




