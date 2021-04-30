//
//  HostView.swift
//  FonzMusicSwift
//
//  Created by didi on 4/27/21.
//

import SwiftUI
import Combine

struct HostView: View {
// ---------------------------------- inherited from parent -----------------------------------------

    
// ---------------------------------- created inside view -------------------------------------------
    // inits the guestTrack, blank
//    @StateObject var guestTrack = GlobalTrack()

    // inits the object that determines if the Guest PageView should update
    @State var hostPagesUpdateDirection = UpdatePageViewVariables()
    // var that sets the current page and starts it at page 0 (join party)
    @State var HostPageActive = 0
    
    var body: some View {
        
        VStack {
            HostContainerView(hostPage: [0, 1],
                               hostPagesUpdateDirection,
                               currentHostPageIndex: $HostPageActive
            ).environmentObject(hostPagesUpdateDirection)
        }.ignoresSafeArea()
    }
}

struct HostView_Previews: PreviewProvider {
    static var previews: some View {
//        GuestView(hasHost: $true)
        Text("so annoying")
    }
}

struct HostPages: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // current page from Controller
    @State var hostPage: Int
    // boolean if page should be updated + int of WHICH page
    @State var updatePageVars:UpdatePageViewVariables
    // current page from Controller
    @Binding var currentHostPageIndex: Int
        
// ---------------------------------- created inside view -------------------------------------------
    // object that stores the songs from the api
    @ObservedObject var hostCoasterList: CoastersFromApi = CoastersFromApi()
    
    var body: some View {
        
        // song search
        if hostPage == 1 {
            HostAddCoaster(determineHostViewUpdate: $updatePageVars, hostPageNumber: $currentHostPageIndex, hostCoasterList: hostCoasterList)
        }
        // Page that prompts user to tap NFC
        else {
            CoasterDashboard(determineHostViewUpdate: $updatePageVars, hostPageNumber: $currentHostPageIndex, hostCoasterList: hostCoasterList)
        }
    }
}

struct HostContainerView: View {
    
    @Binding var currentHostPageIndex: Int
    
    // asks for controller
    var hostControllers: [UIHostingController<HostPages>]
    // environment object that controls whether the view should update and if so, to what page
    @EnvironmentObject var newPageVars: UpdatePageViewVariables
    
    init( hostPage: [Int],

          _ newPage: UpdatePageViewVariables,
          currentHostPageIndex: Binding<Int>) {
        
        self._currentHostPageIndex = currentHostPageIndex

        self.hostControllers = hostPage.map {UIHostingController(rootView: HostPages(hostPage: $0,
                        updatePageVars: newPage,
                        currentHostPageIndex: currentHostPageIndex
        ))}
    }
    
    // pageView
    var body: some View {
//        GuestPageViewController(controllers: self.guestControllers, updatePageVars: newPageVars )
        HostPageViewController(currentHostPageIndex: $currentHostPageIndex, controllers: self.hostControllers, updatePageVars: newPageVars )
    }
}

struct HostPageViewController: UIViewControllerRepresentable {

    @Binding var currentHostPageIndex: Int
    
    var controllers: [UIViewController]
    // passes along environ Object that determines if view should update and if so, to what page
    @State var updatePageVars:UpdatePageViewVariables
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        // this determines the direction of the scroll, made it vertical
        let mainPageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .vertical)
        mainPageViewController.dataSource = context.coordinator
    
        
        
        return mainPageViewController
    }
    
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        context.coordinator.parent = self
        
        if updatePageVars.updatePageReverse {
            updatePageVars.updatePageReverse = false
            uiViewController.setViewControllers([controllers[currentHostPageIndex]], direction: .reverse, animated: true)
        }
        else {
            uiViewController.setViewControllers([controllers[currentHostPageIndex]], direction: .forward, animated: true)
        }
        
    }
    
    typealias UIViewControllerType = UIPageViewController
    
    // this controlls the swiping function
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource {

        // says if you swipe up it updates view, doesnt allow to go past 0
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == 0 {
//                pageViewController.disableSwipeGesture()
                return nil
            }
            return self.parent.controllers[index - 1]
        }
        
        // says if you swipe down it updates view, doesnt allow to go past length - 1
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == 1 {
//                pageViewController.disableSwipeGesture()
                return nil
            }
            else {
                if index == self.parent.controllers.count - 1 {
                    return nil
                }
               
                return self.parent.controllers[index + 1]
            }
        }
        
        var parent: HostPageViewController
        
        init(_ parent: HostPageViewController) {
            self.parent = parent
        }
    }
    
    
}
