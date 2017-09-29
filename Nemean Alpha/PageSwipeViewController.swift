//
//  PageSwipeViewController.swift
//  Nemean Alpha
//
//  Created by Captain on 2017-09-14.
//  Copyright © 2017 Greenr Republic Software Company. All rights reserved.
//

import Foundation
import UIKit
import Material

class PageSwipeViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    var screens = [ScreenDataObject]()
    var screen_name : String = ""
    var run_once: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("PageSwipeViewController viewDidLoad()")
        self.dataSource = self
        self.delegate = self
        screens.removeAll()
        screens = NemeanDatabase.instance.getAllScreens()
        print("All Screens from paging controller: \(screens)")
    
        for screen in screens {
            let page = MainViewController(screen_uuid: screen.uuid)
            self.pages.append(page)
        }
        
        let initialPage = 0
        
        setViewControllers([pages[initialPage]], direction: .forward, animated: false, completion: nil)
        
        prepareToolbar()
        
        // pageControl
        self.pageControl.frame = CGRect()
        self.pageControl.currentPageIndicatorTintColor = UIColor.black
        self.pageControl.pageIndicatorTintColor = UIColor.lightGray
        self.pageControl.numberOfPages = self.pages.count // + 1?
        self.pageControl.currentPage = initialPage
        self.view.addSubview(self.pageControl)
        
        self.pageControl.translatesAutoresizingMaskIntoConstraints = false
        self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
        self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
        self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex == 0 {
                // wrap to last page in array
                return self.pages.last
            } else {
                // go to previous page in array
                return self.pages[viewControllerIndex - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        if let viewControllerIndex = self.pages.index(of: viewController) {
            if viewControllerIndex < self.pages.count - 1 {
                // go to next page in array
                return self.pages[viewControllerIndex + 1]
            } else {
                // wrap to first page in array
                return self.pages.first
            }
        }
        return nil
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        // set the pageControl.currentPage to the index of the current viewController in pages
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = self.pages.index(of: viewControllers[0]) {
                self.pageControl.currentPage = viewControllerIndex
                screen_name = screens[viewControllerIndex].name
                prepareToolbar()
            }
        }
    }
}

extension PageSwipeViewController {
    fileprivate func prepareToolbar() {
        guard let tc = toolbarController else {
            return
        }
        
        if run_once == false {
           screen_name = screens[0].name
            run_once = true
        }
        
        print("preparing PageSwipeViewController toolbar title. Screen name: \(screen_name)")
        tc.toolbar.title = screen_name
        
        
    }
}


