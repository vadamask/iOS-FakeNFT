//
//  OnboardingViewController.swift
//  FakeNFT
//
//  Created by Виктор on 18.11.2023.
//

import UIKit

class OnboardingViewController: UIPageViewController {
    weak var coordinator: AppCoordinator?
    private lazy var orderedViewControllers: [UIViewController] = {
        return [
            OnboardingPage(
                bgImage: Asset.onboarding1BG.image,
                title: L10n.Onboarding.title1,
                description: L10n.Onboarding.description1),
            OnboardingPage(
                bgImage: Asset.onboarding2BG.image,
                title: L10n.Onboarding.title2,
                description: L10n.Onboarding.description2),
            OnboardingPage(
                bgImage: Asset.onboarding3BG.image,
                title: L10n.Onboarding.title3,
                description: L10n.Onboarding.description3,
                button: ActionButton(
                    title: L10n.Onboarding.button,
                    type: .primary
                ) { [weak self] _ in
                    UserDefaults.standard.isOnBoarded = true
                    self?.coordinator?.goToHome()
                }
            )
        ]
    }()

    private var pageControl = ProgressLinePageControl()

    override func viewDidLoad() {
        super.viewDidLoad()
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
        startAnimating()
    }

    private func startAnimating() {
        pageControl.startAnimating()
    }

    private func stopAnimating() {
        pageControl.stopAnimating()
    }

    private func changeSlide() {
        if pageControl.selectedItem == pageControl.numberOfItems - 1 {
            stopAnimating()
            return
        }
        
        let nextIndex = pageControl.selectedItem + 1
        setViewControllers([orderedViewControllers[nextIndex]], direction: .forward, animated: true)
        pageControl.selectedItem = nextIndex
        pageControl.startAnimating()
    }

    private func configurePageControl() {
        pageControl.numberOfItems = orderedViewControllers.count
        pageControl.selectedItem = 0
        pageControl.completion = { [weak self] in
            self?.changeSlide()
        }
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
        stopAnimating()
        if let pageContentViewController = pageViewController.viewControllers?[0] {
            if let index = orderedViewControllers.firstIndex(of: pageContentViewController) {
                pageControl.selectedItem = index
                startAnimating()
            }
        }
    }
}
