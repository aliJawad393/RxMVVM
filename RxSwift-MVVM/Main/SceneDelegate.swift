
import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    private var flow: Flow?
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let parser = ParseManager()
        let networkManager = NetworkManager(parser: parser)
        
        let navigationController = UINavigationController()
        let router = DnaInstaRouter(navigationController: navigationController, viewControllerFactory: iOSViewControllerFactory(databaseManager: CoreDataManager(), networkManager: networkManager))
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        
        flow = Flow(router: router)
        
        flow?.start()
        
    }
}

