//
//  OnboardingViewController.swift
//  FakeNFT
//
//  Created by Виктор on 18.11.2023.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    private let orderedViewControllers: [UIViewController] = {
        return [
            OnboardingPage(
                bgImage: Asset.onboarding1BG.image,
                title: "Исследуйте",
                description: "Присоединяйтесь и откройте новый мир уникальных NFT для коллекционеров"),
            OnboardingPage(
                bgImage: Asset.onboarding2BG.image,
                title: "Коллекционируйте",
                description: "Пополняйте свою коллекцию эксклюзивными картинками, созданными нейросетью!"),
            OnboardingPage(
                bgImage: Asset.onboarding3BG.image,
                title: "Состязайтесь",
                description: "Смотрите статистику других и покажите всем, что у вас самая ценная коллекция",
                button: ActionButton(
                    title: "Что внутри?",
                    type: .primary,
                    action: { _ in
                        print("Clicked")
                    }
                )
            )
        ]
    }()
    var timer: Timer?
    var pageControl = ProgressLinePageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.isOnBoarded = true
        overrideUserInterfaceStyle = .light
        dataSource = self
        delegate = self
        configurePageControl()
        if let firstViewController = orderedViewControllers.first {
            setViewControllers(
                [firstViewController],
                direction: .forward,
                animated: true,
                completion: nil
            )
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }

    func startTimer() {
        timer = Timer.scheduledTimer(
            timeInterval: 3,
            target: self,
            selector: #selector(changeSlide),
            userInfo: nil,
            repeats: true
        )
        pageControl.startAnimating()
    }
    func stopTimer() {
        timer?.invalidate()
        pageControl.stopAnimating()
    }

    @objc func changeSlide() {
        if pageControl.selectedItem == pageControl.numberOfItems - 1 {
            stopTimer()
            return
        }
        
        let nextIndex = pageControl.selectedItem + 1
        setViewControllers([orderedViewControllers[nextIndex]], direction: .forward, animated: true)
        pageControl.selectedItem = nextIndex
        pageControl.startAnimating()
    }

    func configurePageControl() {
        pageControl.numberOfItems = orderedViewControllers.count
        pageControl.selectedItem = 0
        view.addSubview(pageControl)
        pageControl.snp.makeConstraints { make in
            make.width.equalToSuperview().offset(-32)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.height.equalTo(4)
        }
    }
}

extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let previousIndex = viewControllerIndex - 1

        guard previousIndex >= 0 else {
            return nil
        }

        guard orderedViewControllers.count > previousIndex else {
            return nil
        }

        return orderedViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
            return nil
        }

        let nextIndex = viewControllerIndex + 1
        let orderedViewControllersCount = orderedViewControllers.count

        guard orderedViewControllersCount != nextIndex else {
            return nil
        }

        guard orderedViewControllersCount > nextIndex else {
            return nil
        }

        return orderedViewControllers[nextIndex]
    }
}

extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        stopTimer()
        if let pageContentViewController = pageViewController.viewControllers?[0] {
            if let index = orderedViewControllers.firstIndex(of: pageContentViewController) {
                pageControl.selectedItem = index
                startTimer()
            }
        }
    }
}
