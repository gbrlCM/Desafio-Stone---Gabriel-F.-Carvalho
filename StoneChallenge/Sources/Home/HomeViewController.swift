import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private let contentView: HomeView = HomeView()
    private var disposeBag = DisposeBag()
    private let presenter: HomePresenter
    
    init(presenter: HomePresenter = HomePresenter()) {
        self.disposeBag = DisposeBag()
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        title = "Home"
        setupItems()
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
    }
    
    private func setupItems() {
        presenter
            .characters
            .bind(to: contentView.characterCollection.rx.items(cellIdentifier: CharacterCell.identifier, cellType: CharacterCell.self)) { index, item, cell in
                cell.setup(with: item)
            }
            .disposed(by: disposeBag)
        
        contentView
            .characterCollection
            .rx
            .itemSelected
            .map(\.row)
            .bind(with: presenter) { presenter, index in
                presenter.itemSelected(at: index)
            }
            .disposed(by: disposeBag)
    }
}

