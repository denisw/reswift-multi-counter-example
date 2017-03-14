import ReSwift

struct AppReducer: Reducer {

    func handleAction(action: Action, state: AppState?) -> AppState {
        var state = state ?? AppState()

        switch action {
        case let action as ActionIncrementCounter:
            state.counters[action.counterIndex] += 1
        case let action as ActionDecrementCounter:
            state.counters[action.counterIndex] -= 1
        case _ as ActionAddCounter:
            state.counters.append(0)
        default:
            break
        }

        return state
    }
    
}
