
import UIKit

var list = [ToDoListModel]()
class ViewController: UIViewController {
    
    
    @IBOutlet weak var lbMemoCount: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViewUpdate()
    }
    
    //MARK: - addtableView
    private func tableViewUpdate() {
        
        if let data = UserDefaults.standard.data(forKey: "items") {
            let getList = (try? PropertyListDecoder().decode([ToDoListModel].self, from: data)) ?? [ToDoListModel]()
            
            list = getList
        }
        lbMemoCount.text = ("\(list.count)개의 메모")
        tableView.reloadData()
    }
    
    //MARK: - PushCellIndex
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueEdit" {
            let selectedIndex = tableView.indexPathForSelectedRow
            let vc = segue.destination as? CreateViewController
            vc?.getIndex = selectedIndex
            
        }
    }
}


//MARK: - extensionTableView
extension ViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        list.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoListCell", for: indexPath) as? ToDoListCell else {
            return UITableViewCell()
        }
        
        let data = list[indexPath.item]
        cell.configure(data)
        
        return cell
    }
}
extension ViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
}
