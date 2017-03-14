import ReSwift

let globalAppStore = Store<AppState>(
    reducer: AppReducer(),
    state: nil
)
