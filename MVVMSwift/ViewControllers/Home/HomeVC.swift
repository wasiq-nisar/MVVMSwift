//
//  HomeVC.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import UIKit

class HomeVC: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var loading: UILabel!
    
    // MARK: - Variables
    let viewModel = HomeViewModel()
    
    // MARK: - ViewLoad Functions
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: HomeCell.identifier, bundle: nil), forCellReuseIdentifier: HomeCell.identifier)
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loading.isHidden = false
        viewModel.loadData()
    }
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeCell.identifier, for: indexPath) as? HomeCell else {
            print("Error in dequeueReusableCell")
            return UITableViewCell()
        }
        cell.updateUI(data: viewModel.getInfo(for: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}

extension HomeVC: RequestDelegate {
    func didUpdate(with state: ViewState) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            switch state {
            case .idle:
                break
            case .loading:
                loading.isHidden = false
                tableView.isHidden = true
                print("Loading!")
            case .success:
                self.tableView.setContentOffset(.zero, animated: true)
                self.tableView.reloadData()
                loading.isHidden = true
                tableView.isHidden = false
            case .error(let error):
                print(error)
            }
        }
    }
}
