import UIKit

public protocol DataSourcing: NSObject, UITableViewDataSource, UITableViewDelegate {
    associatedtype DataType
    var data: [DataType]? { get }
    func setData(_ data: [DataType]?)
}
