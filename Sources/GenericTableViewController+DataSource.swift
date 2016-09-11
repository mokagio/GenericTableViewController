import UIKit

extension GenericTableViewController: UITableViewDataSource {

  public func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure("Attempted to load the table view without providing a configurator")
    }

    return configurator.data.count
  }

  public func tableView(
    _ tableView: UITableView,
    cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure("Attempted to load the table view without providing a configurator")
    }

    let identifier = configurator.identifierForIndex(indexPath.row)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    let value = configurator.data[indexPath.row]

    if let configurator = configurator.rowsConfigurations.filter({ $0.identifier == identifier })
      .first?
      .configurator {
      return configurator(value, cell)
    } else {
      return cell
    }
  }
}
