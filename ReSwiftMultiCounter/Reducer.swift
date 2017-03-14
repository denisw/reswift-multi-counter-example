import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {
        var counters = state?.counters ?? [0]
        var previousState = state

        switch action {
        case let action as IncrementCounterAction:
            counters[action.counterIndex] += 1
        case let action as DecrementCounterAction:
            counters[action.counterIndex] -= 1
        case _ as AddCounterAction:
            counters.append(0)
        case _ as UndoAction:
            counters = state?.previousState?.counters ?? counters
            previousState = state?.previousState?.previousState
        default:
            break
        }

        return AppState(
            counters: counters,
            previousState: previousState
        )
    }
    
}
