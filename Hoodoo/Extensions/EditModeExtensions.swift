import Foundation
import SwiftUI

extension EditMode {
    mutating func toggle() {
        self = self == .active ? .inactive : .active
    }
}
