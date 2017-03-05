//
//  LeaderboardViewController.swift
//  Schulzzug-iOS
//
//  Created by Niklas Riekenbrauck on 04.03.17.
//  Copyright © 2017 Frederik Riedel. All rights reserved.
//

import UIKit


class LeaderboardViewController: UITableViewController {
    
    var leaderboardItems: [LeaderboardItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DataProvider.default.fetchScores { [weak self] result in
            guard let `self` = self else { return }
            
            switch result {
            case .success(let scores):
                self.leaderboardItems = scores
            case .failure(_):
                self.leaderboardItems = []
                UIAlertController.showError(on: self, with: "Die Scores konnten nicht geladen werden.")
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
        
        tableView.allowsSelection = false;
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaderboardItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaderboardItemCell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row + 1). \(leaderboardItems[indexPath.row].username)"
        cell.detailTextLabel?.text = "\(leaderboardItems[indexPath.row].score)"
        return cell
    }
}
