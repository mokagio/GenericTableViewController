import UIKit
import GenericTableViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    window = UIWindow(frame: UIScreen.mainScreen().bounds)

    let rootTableViewController = GenericTableViewController()
    let navigationController = UINavigationController(rootViewController: rootTableViewController)

    let source = [
      "Touch me to see Ints": {
        navigationController.pushViewController(self.numberTableViewController(), animated: true)
      },
      "Touch me to see String": {
        navigationController.pushViewController(self.stringsTableViewController(), animated: true)
      }
    ]

    let data: [String] = source.keys.map { $0 }
    let cellsConfigurations: [CellConfiguration<String>] = [
      CellConfiguration<String>(
        identifier: "cell",
        cellClass: UITableViewCell.self,
        configurator: { value, cell in
          cell.textLabel?.text = value
          return cell
        },
        handler: { value in
          guard let handler = source[value] else {
            return
          }

          handler()
      })
    ]
    let tableViewConfigurator = TableViewConfiguration<String>(
      data: data,
      cellsConfigurations: cellsConfigurations,
      identifierForIndex: { _ in return "cell" }
    )
    rootTableViewController.tableViewConfigurator = tableViewConfigurator.boxedToAny()

    window?.rootViewController = navigationController

    window?.makeKeyAndVisible()
    return true
  }

  private func numberTableViewController() -> GenericTableViewController {
    let data: [Int] = [1,2,3,4,5]
    let cellsConfigurations: [CellConfiguration<Int>] = [
      CellConfiguration<Int>(
        identifier: "cell",
        cellClass: UITableViewCell.self,
        configurator: { value, cell in
          cell.textLabel?.text = "\(value)"
          return cell
        }
      )
    ]
    let tableViewConfigurator = TableViewConfiguration<Int>(
      data: data,
      cellsConfigurations: cellsConfigurations,
      identifierForIndex: { _ in return "cell" }
    )

    return genericTableViewController(tableViewConfigurator)
  }

  private func stringsTableViewController() -> GenericTableViewController {
    let data: [String] = ["Lorem", "ipsum", "doloret", "..."]
    let cellsConfigurations: [CellConfiguration<String>] = [
      CellConfiguration<String>(
        identifier: "cell",
        cellClass: UITableViewCell.self,
        configurator: { value, cell in
          cell.textLabel?.text = value
          return cell
        }
      )
    ]
    let tableViewConfigurator = TableViewConfiguration<String>(
      data: data,
      cellsConfigurations: cellsConfigurations,
      identifierForIndex: { _ in return "cell" }
    )

    return genericTableViewController(tableViewConfigurator)
  }

  private func genericTableViewController<T>(configuration: TableViewConfiguration<T>) -> GenericTableViewController {
    let genericTableViewController = GenericTableViewController()
    genericTableViewController.tableViewConfigurator = configuration.boxedToAny()
    return genericTableViewController
  }
}
