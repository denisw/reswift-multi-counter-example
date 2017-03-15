import ReSwift
import UIKit

class ViewController: UITableViewController, StoreSubscriber {

    private var counters: [Int]?

    override func viewWillAppear(_ animated: Bool) {
        globalAppStore.subscribe(self) { state in state.counters }
    }

    override func viewWillDisappear(_ animated: Bool) {
        globalAppStore.unsubscribe(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Add Counter",
            style: .plain,
            target: self,
            action: #selector(addCounterPressed)
        )
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            title: "Undo",
            style: .plain,
            target: self,
            action: #selector(undoPressed)
        )

        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CounterCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        return counters?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CounterCell", for: indexPath)

        let count = counters![indexPath.row]
        cell.textLabel?.text = String(count)

        let accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 40))
        cell.accessoryView = accessoryView

        let decrementButton = UIButton(type: .roundedRect)
        decrementButton.setTitle("-", for: .normal)
        decrementButton.tag = indexPath.row
        decrementButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        decrementButton.addTarget(self, action: #selector(decrementPressed), for: .touchUpInside)
        accessoryView.addSubview(decrementButton)

        let incrementButton = UIButton(type: .roundedRect)
        incrementButton.setTitle("+", for: .normal)
        incrementButton.tag = indexPath.row
        incrementButton.frame = CGRect(x: 40, y: 0, width: 40, height: 40)
        incrementButton.addTarget(self, action: #selector(incrementPressed), for: .touchUpInside)
        accessoryView.addSubview(incrementButton)

        return cell
    }

    func addCounterPressed() {
        globalAppStore.dispatch(AddCounterAction())
    }

    func undoPressed() {
        globalAppStore.dispatch(UndoAction())
    }

    func incrementPressed(sender: UIButton) {
        let countIndex = sender.tag
        globalAppStore.dispatch(IncrementCounterAction(counterIndex: countIndex))
    }

    func decrementPressed(sender: UIButton) {
        let countIndex = sender.tag
        globalAppStore.dispatch(DecrementCounterAction(counterIndex: countIndex))
    }

    func newState(state counters: [Int]) {
        updateTitle(fromState: counters)
        updateTableView(fromState: counters)
    }

    private func updateTitle(fromState counters: [Int]) {
        let total = counters.reduce(0) { a, b in a + b }
        navigationItem.title = "Total: \(total)"

        let totalColor: UIColor = {
            if total > 0 {
                return UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            } else if total < 0 {
                return UIColor.red
            } else {
                return UIColor.darkText
            }
        }()

        navigationController?.navigationBar.titleTextAttributes = [
            NSForegroundColorAttributeName: totalColor
        ]
    }

    private func updateTableView(fromState counters: [Int]) {
        self.counters = counters
        tableView.reloadData()
    }

}

