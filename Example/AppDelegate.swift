import UIKit
import GenericTableViewController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(
    application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?
    ) -> Bool {
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
    let rowsConfigurations: [RowConfiguration<String>] = [
      RowConfiguration<String>(
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
      rowsConfigurations: rowsConfigurations,
      identifierForIndex: { _ in return "cell" }
    )
    rootTableViewController.tableViewConfigurator = tableViewConfigurator.boxedToAny()

    window?.rootViewController = navigationController

    window?.makeKeyAndVisible()
    return true
  }

  private func numberTableViewController() -> GenericTableViewController {
    let configuration = TableViewConfiguration<Int>(
      data: [1, 2, 3, 4, 5],
      rowsConfiguration: RowConfiguration<Int>(
        identifier: "cell",
        cellClass: UITableViewCell.self,
        configurator: { value, cell in
          cell.textLabel?.text = "\(value)"
          return cell
        }
      )
    )

    let genericTableViewController = GenericTableViewController()
    // Being an Objective-C class UIViewController doesn't support generics the
    // way Swift does, so we need to "box" our configuration in <T> into <Any>.
    genericTableViewController.tableViewConfigurator = configuration.boxedToAny()

    return genericTableViewController
  }

  private func stringsTableViewController() -> GenericTableViewController {
    let data: [String] = ["Lorem", "ipsum", "doloret", "..."]
    let rowsConfiguration = RowConfiguration<String>(
      identifier: "cell",
      cellClass: UITableViewCell.self,
      configurator: { value, cell in
        cell.textLabel?.text = value
        return cell
      }
    )
    let tableViewConfigurator = TableViewConfiguration<String>(
      data: data,
      rowsConfiguration: rowsConfiguration
    )

    return genericTableViewController(tableViewConfigurator)
  }

  private func genericTableViewController<T>(
    configuration: TableViewConfiguration<T>
    ) -> GenericTableViewController {
    let genericTableViewController = GenericTableViewController()
    genericTableViewController.tableViewConfigurator = configuration.boxedToAny()
    return genericTableViewController
  }
}
