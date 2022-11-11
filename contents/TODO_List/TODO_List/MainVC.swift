import UIKit

import SnapKit

final class MainViewController: UIViewController {
  
  // MARK: - Properties
  
  private let createTodoButton = UIFactory.createTodoButton()
  private var tableView: UITableView!
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupStyles()
    setupLayout()
    setupConstraints()
  }
  
  // MARK: - Setup
  
  private func setupTableView() {
    let tableView = UITableView()
//    tableView.delegate = self
//    tableView.dataSource = self
    self.tableView = tableView
  }
  
  private func setupStyles() {
    view.backgroundColor = .white
    navigationItem.title = "할일"
    createTodoButton.addTarget(self, action: #selector(didTapCreateTodoButton), for: .touchUpInside)
  }
  
  private func setupLayout() {
    view.addSubview(createTodoButton)
    view.addSubview(tableView)
  }
  
  private func setupConstraints() {
    createTodoButton.snp.makeConstraints { make in
      make.leading.trailing.equalToSuperview().inset(24)
      make.top.equalTo(view.safeAreaLayoutGuide).inset(8)
      make.height.equalTo(50)
    }
    
    tableView.snp.makeConstraints { make in
      make.top.equalTo(createTodoButton.snp.bottom).offset(4)
      make.leading.trailing.bottom.equalToSuperview()
    }
  }
  
  // MARK: - Selectors
  
  @objc private func didTapCreateTodoButton() {
    let createTodoVC = CreateTodoViewController()
    navigationController?.pushViewController(createTodoVC, animated: true)
  }
}
