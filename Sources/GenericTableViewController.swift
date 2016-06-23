import UIKit

public class GenericTableViewController: UIViewController {

  public let tableView = UITableView()

  public var tableViewConfigurator: TableViewConfiguration<Any>? {
    didSet {
      tableViewConfigurator?.cellsConfigurations.forEach { info in
        tableView.registerClass(info.cellClass, forCellReuseIdentifier: info.identifier)
      }
    }
  }

  public override func viewDidLoad() {
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
