import UIKit
import RxCocoa
import RxSwift

class HomeViewController: UIViewController {
    
    private let contentView: HomeView = HomeView()
    private var disposeBag = DisposeBag()
    private let presenter: HomePresenter
    
    init(presenter: HomePresenter = HomePresenter(interactor: HomeInteractor(initialState: HomeState()))) {
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
        setupItemsSelection()
        setupInfiniteScroll()
        presenter.viewDidLoad()
        setupBarButtonItems()
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: nil)
    }
    
    private func setupItems() {
        presenter
            .characters
            .observe(on: MainScheduler.instance)
            .bind(to: contentView.characterCollection.rx.items(cellIdentifier: CharacterCell.identifier, cellType: CharacterCell.self)) { index, item, cell in
                cell.setup(with: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupItemsSelection() {
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
    
    private func setupInfiniteScroll() {
        contentView
            .characterCollection
            .rx
            .didScroll
            .map { [weak characterCollection = contentView.characterCollection] _ in
                guard let characterCollection else { return false }
                return characterCollection.didScrollToTheEnd
            }
            .distinctUntilChanged()
            .filter { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(with: presenter, onNext: { presenter, _ in presenter.loadMoreItems() })
            .disposed(by: disposeBag)
    }
}
