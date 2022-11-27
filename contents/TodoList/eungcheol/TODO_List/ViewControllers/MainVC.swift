import UIKit

import Moya
import SnapKit

final class MainViewController: UIViewController {
  
  // MARK: - Properties
  
  private let createTodoButton = UIFactory.createTodoButton()
  private var tableView: UITableView!
  private let service = TodoService.instance
  
  private var todos = [Todo]()
  
  // MARK: - LifeCycle

  override func viewDidLoad() {
    super.viewDidLoad()
    setupTableView()
    setupStyles()
    setupLayout()
    setupConstraints()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    service.getTodos { [weak self] in
      guard let self = self else { return }
      self.todos = $0.reversed()
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Setup
  
  private func setupTableView() {
    let tableView = UITableView()
    tableView.register(
      TodoCell.self,
      forCellReuseIdentifier: TodoCell.identifier
    )
    tableView.delegate = self
    tableView.dataSource = self
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
    let createTodoVC = CreateTodoViewController(.new)
    navigationController?.pushViewController(createTodoVC, animated: true)
  }
}

// MARK: - TableView DataSource

extension MainViewController: UITableViewDataSource {
  func tableView(
    _ tableView: UITableView,
    numberOfRowsInSection section: Int
  ) -> Int {
    return todos.count
  }
  
  func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
  ) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(
      withIdentifier: TodoCell.identifier,
      for: indexPath
    ) as? TodoCell else {
      return UITableViewCell()
    }
    let todo = todos[indexPath.row]
    cell.setupComponents(todo)
    cell.selectionStyle = .none
    
    return cell
  }
}

// MARK: - TableView Delegate

extension MainViewController: UITableViewDelegate {
  func tableView(
    _ tableView: UITableView,
    heightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(
    _ tableView: UITableView,
    estimatedHeightForRowAt indexPath: IndexPath
  ) -> CGFloat {
    return 50
  }
  
  func tableView(
    _ tableView: UITableView,
    didSelectRowAt indexPath: IndexPath
  ) {
    let todo = todos[indexPath.row]
    let createTodoVC = CreateTodoViewController(.existed(todo))
    navigationController?.pushViewController(createTodoVC, animated: true)
  }
}
