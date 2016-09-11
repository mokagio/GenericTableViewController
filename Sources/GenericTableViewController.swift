import UIKit

open class GenericTableViewController: UIViewController {

  open let tableView = UITableView()

  open var tableViewConfigurator: TableViewConfiguration<Any>? {
    didSet {
      tableViewConfigurator?.rowsConfigurations.forEach { info in
        tableView.register(info.cellClass, forCellReuseIdentifier: info.identifier)
      }
    }
  }

  open override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self

    addTableViewToView()
  }

  fileprivate func addTableViewToView() {
    view.addSubview(tableView)

    // We disable this because we'll add all the constraints manually
    tableView.translatesAutoresizingMaskIntoConstraints = false

    view.addConstraints(
      [
        NSLayoutConstraint(equalingAttribute: .top, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .right, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .bottom, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .left, ofItem: tableView, toItem: view),
      ]
    )
  }
}
