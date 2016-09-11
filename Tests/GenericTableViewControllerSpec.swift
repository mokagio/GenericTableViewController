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

        sut.setupViewForTesting()

        expect(configuratorCalled).toEventually(beTrue())
      }
    }

    it("uses the RowConfiguration with the identifier returned by identifierForIndex") {
      let sut = GenericTableViewController()
      var configuratorCalled = false
      let expectedIdentifier = "identifier"
      let rowConfiguration = RowConfiguration<String>(
        identifier: expectedIdentifier,
        cellClass: UITableViewCell.self,
        configurator: { string, cell in
          configuratorCalled = true
          return cell
        }
      )
      let otherRowConfiguration = RowConfiguration<String>(
        identifier: "different-identifier",
        cellClass: UITableViewCell.self,
        configurator: { string, cell in
          fail("This row configuration should not have been called")
          return cell
        }
      )
      let configuration = TableViewConfiguration<String>(
        data: ["a"],
        rowsConfigurations: [rowConfiguration, otherRowConfiguration],
        identifierForIndex: { index in
          return expectedIdentifier
        }
      )
      sut.tableViewConfigurator = configuration.boxedToAny()

      expect(configuratorCalled) == false

      sut.setupViewForTesting()

      expect(configuratorCalled).toEventually(beTrue())
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

        sut.setupViewForTesting()

        let indexPath = IndexPath(row: 1, section: 0)
        sut.tableView.delegate?.tableView?(sut.tableView, didSelectRowAt: indexPath)
      }
    }

    it("sets itself as the datasource of its table view") {
      let sut = GenericTableViewController()
      sut.tableViewConfigurator = tableViewConfiguratorFixture()
      sut.setupViewForTesting()

      guard let dataSource = sut.tableView.dataSource as? GenericTableViewController else {
        fail("Expected dataSource to be an instance of GenericTableViewController")
        return
      }

      expect(dataSource) == sut
    }

    it("sets itself as the delegate of its table view") {
      let sut = GenericTableViewController()
      sut.tableViewConfigurator = tableViewConfiguratorFixture()
      sut.setupViewForTesting()

      guard let delegate = sut.tableView.delegate as? GenericTableViewController else {
        fail("Expected delegate to be an instance of GenericTableViewController")
        return
      }

      expect(delegate) == sut
    }
  }
}

extension GenericTableViewController {

  func setupViewForTesting() {
    // Since we are initializing the view controller outside of the actual
    // app flow we need to explicitly load the view.
    loadViewIfNeeded()

    // Since we are initializing the view controller outside of the actual
    // app flow, and the table view is configured via Auto Layout, we need
    // to explicitly layout it, so that it' s frame is actually set and
    // the view controller internal will considere it "alive" and then call
    // datasource and delegate.
    tableView.setNeedsLayout()
    view.layoutIfNeeded()

    tableView.reloadData()
  }
}

func tableViewConfiguratorFixture() -> TableViewConfiguration<Any> {
  let rowConfigurator: RowConfiguration<String> = RowConfiguration(
    identifier: "i",
    configurator: { value, cell in
      return cell
    }
  )
  let configuration: TableViewConfiguration<String> = TableViewConfiguration(
    data: ["a", "b"],
    rowsConfiguration: rowConfigurator
  )
  return configuration.boxedToAny()
}
