//
//  ContentView.swift
//  FonzMusicSwift
//
//  Created by didi on 4/24/21.
//

import SwiftUI

class UpdateMainPageView: ObservableObject {
    @Published var updatePage = false
}

enum TabIdentifier: Hashable {
  case host, search, settings
}

struct ContentView: View {
    
    @State var selectedTab = TabIdentifier.search
    @State var connectedToSpotify = false
    @State var hasConnectedCoasters = false
    @State var needsToUpdate = false

    // main app
    var body: some View {
        
        
        if needsToUpdate {
            MustUpdateApp()
        }
        else {
            TabView(selection: $selectedTab) {
                HostTab(connectedToSpotify: $connectedToSpotify, hasConnectedCoasters: $hasConnectedCoasters).tabItem {
                    Label("host", systemImage: "homepod")
                }.tag(TabIdentifier.host)
                SearchTab(selectedTab: $selectedTab).tabItem {
                    Label("search", systemImage: "magnifyingglass")
                }.tag(TabIdentifier.search)
                SettingsPage().tabItem {
                    Label("settings", systemImage: "gear")
                }.tag(TabIdentifier.settings)
            }.accentColor(.amber)
            .onAppear {
//                let minVersionNumber = GetVersionApi().getMinVersion(device: "iOS")
//                print("version is \(versionNumber)" )
                let minVersionNumber = "1.02"
                print(UIApplication.appVersion)
                needsToUpdate = determineViewBasedOnVersion(currentVersion: UIApplication.appVersion!, minVersion: minVersionNumber)
            }
            .onOpenURL { url in
                guard let tabIdentifier = url.tabIdentifier else {
                  return
                }
                selectedTab = tabIdentifier
            }
        }
       
    }
    
    func determineViewBasedOnVersion(currentVersion:String, minVersion:String) -> Bool {
//        let currentVersion
//
        // puts version into 2 substrings
        let currentVersionParts = currentVersion.split(separator: ".")
        // gets first part & puts it in hundreds column
        let currentVersionFirst = Int(currentVersionParts[0])! * 100
        // adds parts together to get one number
        let currentVersionNumber = currentVersionFirst + Int(currentVersionParts[1])!
        print("current version \(currentVersionNumber)")

        // puts version into 2 substrings
        let minVersionParts = minVersion.split(separator: ".")
        // gets first part & puts it in hundreds column
        let minVersionFirst = Int(minVersionParts[0])! * 100
        // adds parts together to get one number
        let minVersionNumber = minVersionFirst + Int(minVersionParts[1])!
        print("min version \(minVersionNumber)")
        
        if minVersionNumber > currentVersionNumber {
            return true
        }
        else {return false }
        
        
    }
    
}

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}
extension UIImage {
    static func searchSymbol(scale: SymbolScale) -> UIImage {
        let config = UIImage.SymbolConfiguration(scale: scale)
        return (UIImage(named: "searchIcon")!.withConfiguration(config).withRenderingMode(.alwaysTemplate))
    }
}




struct MainPage: View {
    // active page number for controller
    var pageNumber: Int
    // boolean to determine whether the GuestView allows swiping
    @State var hasHost = false
    @State var numberOfQueus = 0
    @ObservedObject var updatePageBool: UpdateMainPageView
    // boolean if page should be updated + int of WHICH page
    @State var updatePageVars:UpdatePageViewVariables
    
    @Binding var currentPageIndex: Int
    
    

    var body: some View {
        
        


        
        if pageNumber == 0 {
            HostAddSpotify()
        }
        else if pageNumber == 2 || hasHost {
            GuestView(hasHost: $hasHost, queuesUsed: $numberOfQueus)
        }
        else {
            HomePage(currentPageIndex: $currentPageIndex)
            }
            
        
    }
}

struct MainContainerView: View {

    @Binding var currentPageIndex: Int
    
    // will change TitlePage struct later
    var mainControllers: [UIHostingController<MainPage>]
    
    // environment object that controls whether the view should update and if so, to what page
    @EnvironmentObject var newPageVars: UpdatePageViewVariables
    
    init(_ pageNumber: [Int], _ newPage: UpdatePageViewVariables, updatePage: UpdateMainPageView, currentPageIndex: Binding<Int>) {
        
        self._currentPageIndex = currentPageIndex
        
//        currentPageIndex = 0
        
        // inits the controller for the page view
        self.mainControllers = pageNumber.map { UIHostingController(rootView: MainPage(pageNumber: $0, updatePageBool: updatePage, updatePageVars: newPage, currentPageIndex: currentPageIndex))}
    }
    
    // creates the pageView
    var body: some View {
//        MainPageViewController(controllers: self.mainControllers, updatePageVars: newPageVars)
        MainPageViewController(currentPageIndex: $currentPageIndex, controllers: self.mainControllers, updatePageVars: newPageVars)
        
        
    }
    
    
}

struct MainPageViewController: UIViewControllerRepresentable {
    
    @Binding var currentPageIndex: Int
    
    var controllers: [UIViewController]
    // passes along environ Object that determines if view should update and if so, to what page
    @State var updatePageVars:UpdatePageViewVariables
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        // this determines the direction of the scroll
        let mainPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        mainPageViewController.dataSource = context.coordinator
        
        return mainPageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        
        context.coordinator.parent = self
        
        if currentPageIndex == 0 {
            uiViewController.setViewControllers([controllers[currentPageIndex]], direction: .reverse, animated: true)
        }
        else {
            uiViewController.setViewControllers([controllers[currentPageIndex]], direction: .forward, animated: true)
        }
    }
    
    typealias UIViewControllerType = UIPageViewController
    
        // this controlls the swiping function
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    // these update view when swiped
    // also dont allow swiping if out of pages
    class Coordinator: NSObject, UIPageViewControllerDataSource {
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
                return nil
            }
            return self.parent.controllers[index - 1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == self.parent.controllers.count - 1 {
                return nil
            }
            return self.parent.controllers[index + 1]
        }
        
        var parent: MainPageViewController
        
        init(_ parent: MainPageViewController) {
            self.parent = parent
        }
    }
}

// text boxes

struct FonzTitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 56))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
            .padding(.horizontal)

    }
}
struct FonzHeading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-700", size: 40))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
            .padding(.horizontal, 10)

    }
}
struct FonzSubheading: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-500", size: 24))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}
struct FonzParagraphOne: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 24))
            .foregroundColor(Color(.systemGray5))
            .multilineTextAlignment(.center)
//            .padding(.horizontal)
    }
}
struct FonzParagraphTwo: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-300", size: 18))
            .foregroundColor(Color(.systemGray5))
//            .padding(.horizontal)
    }
}
struct FonzParagraphThree: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-100", size: 12))
    }
}
struct FonzAmberButtonText: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("MuseoSans-100", size: 12))
            .foregroundColor(Color.amber)
            
    }
}

// extension so fonts can be used as modifiers
extension View {
    func fonzHeading() -> some View {
        self.modifier(FonzHeading())
    }
    func fonzSubheading() -> some View {
        self.modifier(FonzSubheading())
    }
    func fonzParagraphOne() -> some View {
        self.modifier(FonzParagraphOne())
    }
    func fonzParagraphTwo() -> some View {
        self.modifier(FonzParagraphTwo())
    }
    func fonzParagraphThree() -> some View {
        self.modifier(FonzParagraphThree())
    }
    func fonzAmberButtonText() -> some View {
        self.modifier(FonzAmberButtonText())
    }
    
}
