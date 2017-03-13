import UIKit

class ViewController: UITableViewController {

    private var counts = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Total: 0"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add Counter",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(addCounterPressed))
        
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CounterCell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection _: Int) -> Int {
        return counts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CounterCell", for: indexPath)
        
        let count = counts[indexPath.row]
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
    
    @IBAction func addCounterPressed() {
        counts.append(0)
        tableView.reloadData()
    }
    
    @IBAction func incrementPressed(sender: UIButton) {
        let countIndex = sender.tag
        counts[countIndex] += 1
        
        tableView.reloadData()
        updateTitle()
    }
    
    @IBAction func decrementPressed(sender: UIButton) {
        let countIndex = sender.tag
        counts[countIndex] -= 1
        
        tableView.reloadData()
        updateTitle()
    }
    
    private func updateTitle() {
        let total = counts.reduce(0) { a, b in a + b }
        navigationItem.title = "Total: \(total)"
        
        let totalColor: UIColor = {
            if (total > 0) {
                return UIColor(red: 0, green: 0.5, blue: 0, alpha: 1)
            } else if (total < 0) {
                return UIColor.red
            } else {
                return UIColor.darkText
            }
        }()
        
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: totalColor]
    }
    
}

