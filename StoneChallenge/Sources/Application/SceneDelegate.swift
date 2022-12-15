import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = scene as? UIWindowScene else { return }
        window = UIWindow(windowScene: scene)
        coordinator = MainCoordinator(navigationView: UINavigationController())
        coordinator?.start()

        window?.rootViewController = coordinator?.navigationView
        window?.makeKeyAndVisible()
    }
}

