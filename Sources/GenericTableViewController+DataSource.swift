import UIKit

extension GenericTableViewController: UITableViewDataSource {

  public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  public func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure("Attempted to load the table view without providing a configurator")
    }

    return configurator.data.count
  }

  public func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    guard let configurator = tableViewConfigurator else {
      preconditionFailure("Attempted to load the table view without providing a configurator")
    }

    let identifier = configurator.identifierForIndex(indexPath.row)
    let cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath)
    let value = configurator.data[indexPath.row]

    if let configurator = configurator.cellsConfigurations.filter({ $0.identifier == identifier })
      .first?
      .configurator {
      return configurator(value, cell)
    } else {
      return cell
    }
  }
}
