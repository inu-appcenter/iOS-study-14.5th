//
//  ToDoView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import Hero
import SnapKit
import SwipeCellKit

class ToDoView: UIView {
    
    // MARK: - Properties
    var viewModel: ToDoViewModel?
    weak var delegate: ToDoDelegate?
    
    // MARK: - UI Components
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .tdGray
        return view
    }()
    
    lazy var headerView: UIView = {
        let view = UIView()
        view.snp.makeConstraints { make in
            make.height.equalTo(100)
        }
        return view
    }()
    
    lazy var toDoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 32, weight: .semibold)
        label.textColor = .white
        label.text = "할 일"
        return label
    }()
    
    lazy var doneLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .tdLightGray
        label.text = "0 / 0"
        return label
    }()
    
    lazy var addButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.addTarget(self, action: #selector(addButtonDidTap), for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.width.height.equalTo(48)
        }
        button.hero.id = HeroID.Home2Edit.buttonTransition
        return button
    }()
    
    @objc func addButtonDidTap() {
        self.delegate?.addButtonDidTap()
    }
    
    lazy var headerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(self.toDoLabel)
        stackView.addArrangedSubview(self.doneLabel)
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    lazy var todoCollectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: UICollectionViewLayout()
        )
        collectionView.register(ToDoCell.self, forCellWithReuseIdentifier: ToDoCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        collectionView.collectionViewLayout = layout
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        collectionView.addGestureRecognizer(lpgr)
        return collectionView
    }()
    
    // MARK: - Initializers
    convenience init(todoViewModel: ToDoViewModel) {
        self.init(frame: .zero)
        self.viewModel = todoViewModel
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    func refresh() {
        self.todoCollectionView.reloadData()
    }
}

// MARK: - UI Configuration
private extension ToDoView {
    func configureUI() {
        self.configureLayout()
        self.configureConstraints()
        self.configureStyles()
    }
    
    func configureLayout() {
        [headerView, contentView].forEach {
            self.addSubview($0)
        }
        [headerStackView, addButton].forEach {
            self.headerView.addSubview($0)
        }
        self.contentView.addSubview(self.todoCollectionView)
    }
    
    func configureConstraints() {
        self.headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        self.contentView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
        }
        self.headerStackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(32)
        }
        self.addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(32)
        }
        self.todoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureStyles() {
        self.clipsToBounds = true
        self.backgroundColor = .tdGray
        self.layer.cornerRadius = 32
        
        self.addButton.layer.cornerRadius = 24
    }
}

// MARK: - Collection View
extension ToDoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return ToDoManager.shared.todos.count
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UICollectionViewCell()
        }
        let todoData = ToDoManager.shared.todos[indexPath.item]
        cell.delegate = self
        cell.bind(todoData)
        return cell
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ToDoCell else {
            return
        }
        if let todo = cell.todo {
            HapticManager.shared.impactFeedback(.soft)
            self.viewModel?.todoRequest(method: .toggle, with: todo)
        }
        self.todoCollectionView.reloadData()
    }
}

extension ToDoView: SwipeCollectionViewCellDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsForItemAt indexPath: IndexPath,
        for orientation: SwipeCellKit.SwipeActionsOrientation
    ) -> [SwipeCellKit.SwipeAction]? {
        guard orientation == .right else { return nil }
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) as? ToDoCell else {
                return
            }
            if let todo = cell.todo {
                print(todo)
                self.viewModel?.todoRequest(method: .delete, with: todo)
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash.fill")

        return [deleteAction]
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        editActionsOptionsForItemAt indexPath: IndexPath,
        for orientation: SwipeActionsOrientation
    ) -> SwipeOptions {
        var options = SwipeOptions()
        options.expansionStyle = .destructiveAfterFill
        options.transitionStyle = .border
        return options
    }
}

// MARK: - Long Press
extension ToDoView: UIGestureRecognizerDelegate {
    @objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        guard gestureReconizer.state == .began else { return }
        let point = gestureReconizer.location(in: self.todoCollectionView)
        let indexPath = self.todoCollectionView.indexPathForItem(at: point)
        if let indexPath {
            HapticManager.shared.impactFeedback(.light)
            guard let pressedCell = self.todoCollectionView.cellForItem(at: indexPath) as? ToDoCell else {
                return
            }
            if let todo = pressedCell.todo {
                self.delegate?.cellDidLongPressed(with: todo)
            }
        }
        else {
            print("Could not find index path")
        }
    }
}
