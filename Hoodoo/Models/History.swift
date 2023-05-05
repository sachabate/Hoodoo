import Foundation
import CoreData

class History: NSManagedObject, Identifiable {
    @NSManaged var id: UUID
    @NSManaged var label: String
    @NSManaged var desc: String
    @NSManaged var completed: Date
}
