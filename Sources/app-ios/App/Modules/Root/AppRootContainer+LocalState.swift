import Combine
import SwiftUI

extension AppRootContainer {
    class LocalState: ObservableObject {
        @Published var currentPage: Page = .main

        func setPage(_ newPage: Page) {
            currentPage = newPage
        }
    }
}
