//
//  EditViewModel.swift
//  ToDo
//
//  Created by 이창준 on 2022/11/23.
//

import Foundation

final class EditViewModel {
    
    // MARK: - Properties
    weak var coordinator: EditCoordinator?
    let editUseCase: EditUseCase
    let editViewControllerType: EditViewControllerType
    
    var confirmButtonText: String {
        switch editViewControllerType {
        case .update:
            return "수정하기"
        case .create:
            return "추가하기"
        }
    }
    
    // MARK: - Observables
    var todo: Observable<ToDo?> = Observable(nil)
    
    // MARK: - Initializer
    init(
        coordinator: EditCoordinator,
        editUseCase: EditUseCase,
        editViewControllerType: EditViewControllerType
    ) {
        self.coordinator = coordinator
        self.editUseCase = editUseCase
        self.editViewControllerType = editViewControllerType
        self.todo.value = self.createNewToDo()
    }
    
    init(
        coordinator: EditCoordinator,
        editUseCase: EditUseCase,
        editViewControllerType: EditViewControllerType,
        todoDataToEdit: ToDo
    ) {
        self.coordinator = coordinator
        self.editUseCase = editUseCase
        self.editViewControllerType = editViewControllerType
        self.todo.value = todoDataToEdit
    }
    
    // MARK: - Functions
    func confirmButtonDidTap(completion: (() -> Void)) {
        guard let todo = self.todo.value else { return }
        switch self.editViewControllerType {
        case .create:
            self.editUseCase.createToDo(todo) {
                self.coordinator?.finish()
            }
        case .update:
            self.editUseCase.updateToDo(todo) {
                self.coordinator?.finish()
            }
        }
        completion()
    }
    
    func updateToDoTitle(to title: String?) {
        if let title {
            self.todo.value?.title = title
        }
    }
    
    func updateToDoDueDate(to date: Date?) {
        if let date {
            self.todo.value?.dueDate = date
        }
    }
    
    func updateToDoDescription(to description: String?) {
        if let description {
            self.todo.value?.description = description
        }
    }
}

// MARK: - Private Functions
private extension EditViewModel {
    func createNewToDo() -> ToDo {
        return ToDo(
            title: "",
            description: "",
            state: .notStarted,
            dueDate: .now,
            created: .now
        )
    }
    
    func calculateState(with dueDate: Date?) -> State {
        guard let unbindedDueDate = dueDate else { return .notStarted }
        // TODO 날짜만 비교
        return (unbindedDueDate.onlyDate < .now.onlyDate) ? .expired : .notStarted
    }
}
