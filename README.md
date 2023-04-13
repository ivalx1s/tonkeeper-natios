# Tonkeeper Natios - Native iOS Wallet for TON Blockchain Network

*Natios (noun):*

*/ˈnɑ.ti.oʊz/*

- *A native implementation of an app, particularly for iOS devices, characterized by its lack of wrapping or coating, thereby offering a simple, streamlined user experience.*
- *A term inspired by the simplicity and deliciousness of Mexican nachos, used to describe the unwrapped and efficient design of an app on iOS devices, emphasizing its direct and unencumbered functionality.*

*Example: The Tonkeeper Natios wallet offers a natios experience for its users, making it easy to manage TON coins on iOS devices with its streamlined design.*


## 🚧 WIP

Tonkeeper Natios is an open-source, native iOS wallet for the TON blockchain network, built using SwiftUI and Swift. Our main focus is to provide a secure, maintainable, and delightful user experience. This project adheres to a strict policy regarding third-party dependencies and aims to eliminate the complexity associated with additional layers.


### 💡 Rationale

- Simplify the development process and boost security by choosing native core UI frameworks over alternatives like React Native, Flutter, or Xamarin.
- Harness the power of SwiftUI to craft a delightful user interface that remains maintainable and minimizes state management bugs.
- Rely on Swift's robust memory management to prevent a range of bugs, ensuring the utmost safety and reliability for a cryptocurrency wallet.

### 🚨 Dependencies Policy

- Careful selection, evaluation, and audit of all third-party code.
- Linking third-party repositories is prohibited; all dependencies should persist under the Tonkeeper organization control (proxy all third-party code through forks).
- Strictly necessary to react to all updates of third-party code, make code reviews, and incorporate updates if no issues were found.

### 💼 Dependencies

- ton-swift: implementation of TON core data structures
- swinject: lightweight DI
- darwin-perdux: small architecture library.
- swift-collections: official Swift/Apple package with useful data structures 
- swift-(async)algorithms: official Swift/Apple packages with useful algorythms
- swift-numerics: required by algorythms, not used directly
- sandbox-permissions-ios: small helper library for working with iOS sandbox permissions.
- darwin-foundationplus: helper extensions for the Foundation framework.
- swift-stdlibplus: useful extensions for the Swift standard library.
- darwin-logger: small wrapper for the os.log system.
- swiftui-plus: useful extensions for SwiftUI.
- darwin-keychainaccess: helper utility to ease and streamline access to iOS keychain (fork of the well-known library by kishikawakatsumi).
- darwin-filemanager: helper wrapper for the Foundation's FileManager.
- hapticshelper-ios: tiny wrapper to work with predefined haptics.

Refer to DEPENDENCIES.md for a detailed overview and rationaly.
### 🛠️ Project Setup

The Xcodeproj file is not stored in the repository. For project file generation, we rely on Xcodegen.

### 🏛️ Architecture

Tonkeeper Natios follows a Redux-like architecture with a unidirectional data flow. View definitions are separated into Views and View Containers. Views only get the data they need through arguments, while Containers may define callbacks, be injected with observable objects, etc.

Refer to ARCHITECTURE.md for detailed explanation of project architecture.

## 🌍 Contributing

We warmly welcome contributions from developers who want to join the project. Please follow these steps to get started:

1. Fork the repository and clone it locally.
2. Install Xcodegen if you don't have it already.
3. Generate the Xcode project using Xcodegen.
4. Make your changes and create a pull request.

Please adhere to our code style and ensure your changes don't introduce new dependencies or security issues. We highly appreciate your efforts to improve the Tonkeeper Natios project.

## ⚖️ License

This project is licensed under the [Apache-2.0 license](LICENSE).
