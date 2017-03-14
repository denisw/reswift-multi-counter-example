import ReSwift

struct IncrementCounterAction: Action {
    let counterIndex: Int
}

struct DecrementCounterAction: Action {
    let counterIndex: Int
}

struct AddCounterAction: Action {
}

struct UndoAction: Action {
}
