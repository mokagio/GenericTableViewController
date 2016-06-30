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

    addTableViewToView()
  }

  private func addTableViewToView() {
    view.addSubview(tableView)

    // We disable this because we'll add all the constraints manually
    tableView.translatesAutoresizingMaskIntoConstraints = false

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
