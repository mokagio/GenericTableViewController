import UIKit

class GenericTableViewController: UIViewController {

  let tableView = UITableView()

  var tableViewConfigurator: TableViewConfiguration<Any>? {
    didSet {
      tableViewConfigurator?.cellsConfigurations.forEach { info in
        tableView.registerClass(info.cellClass, forCellReuseIdentifier: info.identifier)
      }
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self

    tableView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(tableView)

    view.addConstraints(
      [
        NSLayoutConstraint(equalingAttribute: .Top, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .RightMargin, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .BottomMargin, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .LeftMargin, ofItem: tableView, toItem: view),
      ]
    )
  }
}
