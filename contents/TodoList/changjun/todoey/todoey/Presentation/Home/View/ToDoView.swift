//
//  ToDoView.swift
//  todoey
//
//  Created by 이창준 on 2022/11/11.
//

import UIKit

import SnapKit
import Then
import SwipeCellKit

protocol ToDoViewDelegate: AnyObject {
    func showEditView(isEdit: Bool, idx: Int?)
}

class ToDoView: UIView {
    
    private let todo = ToDoManager.shared
    private var viewModel = HomeViewModel.shared
    weak var delegate: ToDoViewDelegate?
    
    // MARK: - UI Components
    lazy var contentView = UIView().then {
        $0.backgroundColor = Color.deepGray
    }
    
    private let headerView = UIView()
    
    lazy var toDoLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 32, weight: .semibold)
        $0.textColor = .white
        $0.text = "할 일"
    }
    
    lazy var doneLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16, weight: .regular)
        $0.textColor = Color.subGray
        $0.text = "0 / 0"
    }
    
    lazy var addButton = UIButton().then {
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.backgroundColor = .systemIndigo
        let tapGesture = UITapGestureRecognizer(
            target: self, action: #selector(handleTap))
        $0.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap() {
        viewModel.handleAddButtonTapEvent()
        self.delegate?.showEditView(isEdit: false, idx: nil)
    }
    
    lazy var headerStackView = UIStackView().then {
        $0.addArrangedSubview(self.toDoLabel)
        $0.addArrangedSubview(self.doneLabel)
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    lazy var todoCollectionView = UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewLayout()
    ).then {
        $0.register(ToDoCell.self, forCellWithReuseIdentifier: ToDoCell.identifier)
        $0.delegate = self
        $0.dataSource = self
        $0.backgroundColor = .clear
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 60)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 4
        $0.collectionViewLayout = layout
        
        let lpgr = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delaysTouchesBegan = true
        lpgr.delegate = self
        $0.addGestureRecognizer(lpgr)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
        self.viewModel.todoUpdated()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
            make.height.equalTo(100)
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
            make.width.height.equalTo(48)
        }
        self.todoCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configureStyles() {
        self.clipsToBounds = true
        self.backgroundColor = Color.deepGray
        self.layer.cornerRadius = 32
        
        self.addButton.layer.cornerRadius = 24
    }
}

// MARK: - Collection View
extension ToDoView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ToDoManager.shared.todos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ToDoCell.identifier, for: indexPath) as? ToDoCell else {
            return UICollectionViewCell()
        }
        cell.delegate = self
        let todoData = todo.todos[indexPath.item]
        cell.bind(todoData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ToDoCell else {
            return
        }
        if let todo = cell.todo {
            print("Toggle state of data named \(todo.title)")
            HapticManager.shared.impactFeedback(.soft)
            self.viewModel.toggleToDo(of: todo)
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
                print("Removing data named \(todo.title)")
                self.viewModel.removeToDo(todo)
            }
        }

        // customize the action appearance
        deleteAction.image = UIImage(systemName: "trash.fill")

        return [deleteAction]
    }
    
    func collectionView(_ collectionView: UICollectionView, editActionsOptionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> SwipeOptions {
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
        if indexPath != nil {
            print("Long Pressed")
            HapticManager.shared.impactFeedback(.light)
            self.delegate?.showEditView(isEdit: true, idx: indexPath?.row)
        }
        else {
            print("Could not find index path")
        }
    }
}

// MARK: - Preview

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct ToDoPreView: PreviewProvider {
    static var previews: some View {
        ToDoView().toPreview()
    }
}
#endif
