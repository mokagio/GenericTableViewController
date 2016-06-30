import UIKit

public class GenericTableViewController: UIViewController {

  public let tableView = UITableView()

  public var tableViewConfigurator: TableViewConfiguration<Any>? {
    didSet {
      tableViewConfigurator?.rowsConfigurations.forEach { info in
        tableView.registerClass(info.cellClass, forCellReuseIdentifier: info.identifier)
      }
    }
  }

  public override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self

    tableView.translatesAutoresizingMaskIntoConstraints = false

    view.addSubview(tableView)

    view.addConstraints(
      [
        NSLayoutConstraint(equalingAttribute: .Top, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .Right, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .Bottom, ofItem: tableView, toItem: view),
        NSLayoutConstraint(equalingAttribute: .Left, ofItem: tableView, toItem: view),
      ]
    )
  }
}
