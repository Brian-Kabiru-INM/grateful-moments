# Grateful Moments

**Grateful Moments** is a SwiftUI app designed to help you capture, reflect on, and celebrate the positive experiences in your life. Built with **SwiftData** for persistence, the app provides a clean interface to record moments, attach notes or images, and revisit them whenever you need a reminder of gratitude.

***

## Features

### **Moments Tab**

The **Moments** tab is the heart of the app; to create, browse, and manage all your gratitude entries.

*   **Add New Moments**  
    Record what you’re grateful for with a title, detailed note, and optional image via a plus toolbarItem.

*   **Dynamic List View**  
    A SwiftUI-powered list displays all your saved moments.

*   **Moment Detail Editing**  
    Tapping on a moment opens the `MomentDetailView`, where you can:
    *   Edit the title
    *   Update the note
    *   Change the attached image
    *   Delete the moment entirely

*   **SwiftData Integration**  
    All entries are stored locally using **SwiftData**, ensuring fast and lightweight persistence without external dependencies.

***

### **Achievements Tab (UIKit)**

The **Achievements** tab has been upgraded to utilize **UIKit**, showcasing a 3‑screen flow built programmatically** using `UINavigationController`:

## Tech Stack

*   **SwiftUI** – Declarative UI framework for building primary app screens
*   **SwiftData** – Native persistence layer for Moments
*   **UIKit** – Used for the Achievements tab and its 3‑screen navigation flow
*   **NavigationStack & TabView** – Structuring navigation and tab-based layout
*   **UINavigationController (programmatic)** – Powering the UIKit achievements workflow
*   **Reusable Components** – Custom, consistent UI
*   **Swift Concurrency** – For smooth UI handling without blocking

***

## Getting Started

1.  Clone the repository:
    ```bash
    git clone https://github.com/Brian-Kabiru-INM/grateful-moments.git
    ```

2.  Open the project in Xcode:
    ```bash
    cd grateful-moments
    open GratefulMoments.xcodeproj
    ```

3.  Build and run on iOS 17+ (recommended).
