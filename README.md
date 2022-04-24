# ActivityView

A popover view that you use to offer standard services from your app.

```swift
import SwiftUI
import ActivityView

struct ContentView: View {
    @Environment(\.activityView) private var activityView
    
    @State private var isSharing = false
    
    var body: some View {
        Button {
            activityView([URL(string: "https://dmkskn.com")!])
        } label: {
            Text("Share")
        }
    }
}
```
