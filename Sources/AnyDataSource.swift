import UIKit

public final class AnyDataSource<DataType>: NSObject, DataSourcing {
    // MARK: - internal properties
    public var data: [DataType]?

    // MARK: - callbacks
    private var tableViewNumberOfRowsInSection: (_ tableView: UITableView, _ section: Int) -> Int
    private var tableViewCellForRowAt: (_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell
    private var tableViewDidSelectRowAt: ((_ tableView: UITableView, _ indexPath: IndexPath) -> Void)?
    private var setDataClosure: (_ data: [DataType]?) -> Void

    // MARK: - init
    public init<DataSourceType: DataSourcing>(_ dataSource: DataSourceType) where DataSourceType.DataType == DataType {
        tableViewNumberOfRowsInSection = dataSource.tableView
        tableViewCellForRowAt = dataSource.tableView(_:cellForRowAt:)
        tableViewDidSelectRowAt = dataSource.tableView(_:didSelectRowAt:)
        setDataClosure = dataSource.setData
    }

    // MARK: - functions
    public func setData(_ data: [DataType]?) {
        setDataClosure(data)
    }

    // MARK: - Table DataSource methods
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableViewNumberOfRowsInSection(tableView, section)
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableViewCellForRowAt(tableView, indexPath)
    }

    // MARK: - Table Delegate methods
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableViewDidSelectRowAt?(tableView, indexPath)
    }

}
