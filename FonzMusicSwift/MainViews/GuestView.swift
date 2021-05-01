//
//  GuestView.swift
//  Fonz Music App Clip
//
//  Created by didi on 1/31/21.
//

import SwiftUI
import Combine


struct GuestView: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // Bool from parent that determines whether the guest can swipe
    @Binding var hasHost:Bool
    // Number of queues the guest has used
    @Binding var queuesUsed:Int
    
// ---------------------------------- created inside view -------------------------------------------
    // inits the guestTrack, blank
//    @StateObject var guestTrack = GlobalTrack()
    // inits the hostCoaster, blank
    @ObservedObject var hostCoasterDetails = HostCoasterInfo()
    // inits the object that determines if the Guest PageView should update
    @State var guestPagesUpdateDirection = UpdatePageViewVariables()
    // var that sets the current page and starts it at page 0 (join party)
    @State var GuestPageActive = 0
    
    var body: some View {
        
        VStack {
            GuestContainerView(guestPage: [0, 1],
//                               track: self.guestTrack,
                               coaster: self.hostCoasterDetails, guestPagesUpdateDirection,
//                               queueAmount: $queuesUsed,
                               currentGuestPageIndex: $GuestPageActive
            ).environmentObject(guestPagesUpdateDirection)
        }.ignoresSafeArea()
    }
}

struct GuestView_Previews: PreviewProvider {
    static var previews: some View {
//        GuestView(hasHost: $true)
        Text("so annoying")
    }
}

struct GuestPages: View {
// ---------------------------------- inherited from parent -----------------------------------------
    // current page from Controller
    @State var guestPage: Int
    // song selected by user
//    @State var currentSong:GlobalTrack
    // coaster tapped by user
    @State var coasterInfo:HostCoasterInfo
    // boolean if page should be updated + int of WHICH page
    @State var updatePageVars:UpdatePageViewVariables
    // current page from Controller
    @Binding var currentGuestPageIndex: Int
        
// ---------------------------------- created inside view -------------------------------------------
    // boolean on has host, always true for this page, needs to be passed into JoinParty
    @State var hasHost = false
    // Number of queues the guest has used
//    @Binding var queuesUsed:Int
    
    var body: some View {
        ZStack {
        // song search
        if guestPage == 1 {
            SearchBarFromMedium(determineGuestViewUpdate: $updatePageVars, hostCoaster: coasterInfo, guestPageNumber: $currentGuestPageIndex)
        }
        // Page that prompts user to tap NFC
        else {
            JoinParty(determineGuestViewUpdate: $updatePageVars, hostCoaster: coasterInfo, hasHostVar: $hasHost, guestPageNumber: $currentGuestPageIndex)
        }
        }.onAppear {
//            currentGuestPageIndex = guestPage
        }
    }
}

struct GuestContainerView: View {
    
    @Binding var currentGuestPageIndex: Int
    
    // asks for controller
    var guestControllers: [UIHostingController<GuestPages>]
    // environment object that controls whether the view should update and if so, to what page
    @EnvironmentObject var newPageVars: UpdatePageViewVariables
    
    init( guestPage: [Int],
//          track: GlobalTrack,
          coaster: HostCoasterInfo,
          _ newPage: UpdatePageViewVariables,
//          queueAmount: Binding<Int>,
          currentGuestPageIndex: Binding<Int>) {
        
        self._currentGuestPageIndex = currentGuestPageIndex

        self.guestControllers = guestPage.map {UIHostingController(rootView: GuestPages(guestPage: $0,
//                        currentSong: track,
                        coasterInfo: coaster,
                        updatePageVars: newPage,
                        currentGuestPageIndex: currentGuestPageIndex
//                        queuesUsed: queueAmount
        ))}
    }
    
    // pageView
    var body: some View {
//        GuestPageViewController(controllers: self.guestControllers, updatePageVars: newPageVars )
        GuestPageViewController(currentGuestPageIndex: $currentGuestPageIndex, controllers: self.guestControllers, updatePageVars: newPageVars )
    }
}

struct GuestPageViewController: UIViewControllerRepresentable {

    @Binding var currentGuestPageIndex: Int
    
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
            uiViewController.setViewControllers([controllers[currentGuestPageIndex]], direction: .reverse, animated: true)
        }
        else {
            uiViewController.setViewControllers([controllers[currentGuestPageIndex]], direction: .forward, animated: true)
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
                pageViewController.disableSwipeGesture()
                return nil
            }
            return self.parent.controllers[index - 1]
        }
        
        // says if you swipe down it updates view, doesnt allow to go past length - 1
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = self.parent.controllers.firstIndex(of: viewController) else { return nil }
            if index == 1 {
                pageViewController.disableSwipeGesture()
                return nil
            }
            else {
                if index == self.parent.controllers.count - 1 {
                    return nil
                }
               
                return self.parent.controllers[index + 1]
            }
        }
        
        var parent: GuestPageViewController
        
        init(_ parent: GuestPageViewController) {
            self.parent = parent
        }
    }
    
    
}
extension UIPageViewController {

    func enableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = true
            }
        }
    }

    func disableSwipeGesture() {
        for view in self.view.subviews {
            if let subView = view as? UIScrollView {
                subView.isScrollEnabled = false
            }
        }
    }
}

