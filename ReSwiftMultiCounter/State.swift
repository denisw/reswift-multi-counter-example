import Foundation
import ReSwift

class AppState: StateType {
    let counters: [Int]
    let previousState: AppState?

    init(counters: [Int], previousState: AppState?) {
        self.counters = counters
        self.previousState = previousState
    }
}



