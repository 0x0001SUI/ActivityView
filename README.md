# ActivityView

A popover view that you use to offer standard services from your app.

```swift
import SwiftUI
import ActivityView

struct ContentView: View {
    @State private var isSharing = false
    
    var body: some View {
        Button {
            isSharing = true
        } label: {
            Text("Share")
        }
        .activityView(isPresented: $isSharing, for: URL(string: "https://dmkskn.com")!])
    }
}
```
