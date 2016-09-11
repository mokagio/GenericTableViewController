import Quick
import Nimble
import GenericTableViewController

class TableViewConfigurationSingleInitSpec: QuickSpec {
  override func spec() {

    describe("TableViewConfiguration") {

      context("when initialized with the single row configuration shorthand") {
        var sut: TableViewConfiguration<Any>!
        let rowConfiguration = RowConfiguration<Any>(
          identifier: "an-identifier",
          cellClass: UITableViewCell.self,
          configurator: { _, cell in return cell },
          handler: .none
        )

        beforeEach {
          sut = TableViewConfiguration<Any>(data: [], rowsConfiguration: rowConfiguration)
        }

        it("has an array of row configurations of size 1") {
          expect(sut.rowsConfigurations.count) == 1
        }

        it("has an array of row configuratinos containig the given row configuration") {
          expect(sut.rowsConfigurations.contains(where: { current -> Bool in
            // This might not be the best equality check for RowConfiguration,
            // but it seems enough in the context of this test
            return current.identifier == rowConfiguration.identifier
              && current.cellClass == current.cellClass
          })).to(beTrue())
        }

        // swiftlint:disable:next line_length
        it("has a ___ function that always returns the identifier from the given row configuration") {
          (0...100).forEach { index in
            expect(sut.identifierForIndex(index)) == rowConfiguration.identifier
          }
        }
      }
    }
  }
}
