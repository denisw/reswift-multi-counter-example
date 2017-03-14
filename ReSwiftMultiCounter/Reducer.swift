import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {
        let state = state ?? AppState(counters: [0])
        var counters = state.counters

        switch action {
        case let action as IncrementCounterAction:
            counters[action.counterIndex] += 1
        case let action as DecrementCounterAction:
            counters[action.counterIndex] -= 1
        case _ as AddCounterAction:
            counters.append(0)
        default:
            break
        }

        return AppState(counters: counters)
    }
    
}
