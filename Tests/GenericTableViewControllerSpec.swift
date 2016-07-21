import Quick
import Nimble
import GenericTableViewController

class GenericTableViewControllerSpec: QuickSpec {
  override func spec() {

    describe("GenericTableViewController") {

      it("calls RowConfiguration configureCell function when rendering cells") {
        let sut = GenericTableViewController()
        var configuratorCalled = false
        let rowConfiguration = RowConfiguration<String>(
          identifier: "cell",
          cellClass: UITableViewCell.self,
          configurator: { string, cell in
            configuratorCalled = true
            return cell
          }
        )
        let configuration = TableViewConfiguration<String>(
          data: ["a"],
          rowsConfiguration: rowConfiguration
        )
        sut.tableViewConfigurator = configuration.boxedToAny()

        expect(configuratorCalled) == false

        // Since we are initializing the view controller outside of the actual
        // app flow we need to explicitly load the view.
        sut.loadViewIfNeeded()

        // Since we are initializing the view controller outside of the actual
        // app flow, and the table view is configured via Auto Layout, we need
        // to explicitly layout it, so that it' s frame is actually set and
        // the view controller internal will considere it "alive" and then call
        // datasource and delegate.
        sut.tableView.setNeedsLayout()
        sut.view.layoutIfNeeded()

        sut.tableView.reloadData()

        expect(configuratorCalled).toEventually(beTrue())
      }
    }

    it("calls the RowConfiguration handler function when a cell is selected") {
      waitUntil { done in
        let data = ["a", "b", "c"]
        let indexToSelect = 1
        let sut = GenericTableViewController()
        let rowConfiguration = RowConfiguration<String>(
          identifier: "cell",
          cellClass: UITableViewCell.self,
          configurator: { string, cell in
            return cell
          },
          handler: { string in
            expect(string) == data[indexToSelect]
            done()
          }
        )
        let configuration = TableViewConfiguration<String>(
          data: data,
          rowsConfiguration: rowConfiguration
        )
        sut.tableViewConfigurator = configuration.boxedToAny()

        // Since we are initializing the view controller outside of the actual
        // app flow we need to explicitly load the view.
        sut.loadViewIfNeeded()

        // Since we are initializing the view controller outside of the actual
        // app flow, and the table view is configured via Auto Layout, we need
        // to explicitly layout it, so that it' s frame is actually set and
        // the view controller internal will considere it "alive" and then call
        // datasource and delegate.
        sut.tableView.setNeedsLayout()
        sut.view.layoutIfNeeded()

        sut.tableView.reloadData()

        let indexPath = NSIndexPath(forRow: 1, inSection: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAtIndexPath: indexPath)
      }
    }
  }
}
