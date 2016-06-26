extension TableViewConfiguration {

  public func boxedToAny() -> TableViewConfiguration<Any> {
    let boxedConfigurations: [RowConfiguration<Any>] = rowsConfigurations.map { $0.boxedToAny() }
    return TableViewConfiguration<Any>(
      data: data.map { $0 },
      rowsConfigurations: boxedConfigurations,
      identifierForIndex: identifierForIndex
    )
  }
}
