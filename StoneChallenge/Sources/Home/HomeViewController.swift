import UIKit
import RxSwift

class HomeViewController: UIViewController {
    
    private let contentView: HomeView = HomeView()
    private var disposeBag = DisposeBag()
    private let presenter: HomePresenterProtocol
    
    init(presenter: HomePresenterProtocol = HomePresenter(interactor: HomeInteractor(initialState: HomeState()))) {
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
        setupPullUpToRefresh()
        setupViewState()
        presenter.initialLoad()
        setupBarButtonItems()
        setupNavigationBarStyle()
    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .plain, target: self, action: #selector(filterBarButtonItemTapped))
    }
    
    private func setupNavigationBarStyle() {
        navigationItem.title = "Rick and Morty"
        navigationController?.navigationBar.applyDefaultStyle()
    }
    
    private func setupItems() {
        presenter
            .viewModel
            .map(\.cells)
            .distinctUntilChanged()
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
            .bind {[weak presenter] index in
                presenter?.itemSelected(at: index)
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
            .subscribe { [weak presenter] _ in presenter?.loadMoreItems() }
            .disposed(by: disposeBag)
    }
    
    private func setupPullUpToRefresh() {
        contentView
            .refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe{[weak presenter] _ in
                presenter?.initialLoad()
            }
            .disposed(by: disposeBag)
        
        presenter
            .viewModel
            .map(\.cells)
            .observe(on: MainScheduler.instance)
            .subscribe(with: contentView) { contentView, _ in
                guard contentView.refreshControl.isRefreshing else { return }
                contentView.refreshControl.endRefreshing()
            }
            .disposed(by: disposeBag)
    }
    
    private func setupViewState() {
        presenter
            .viewModel
            .map(\.viewState)
            .observe(on: MainScheduler.instance)
            .subscribe(with: contentView) {contentView, state in
                switch state {
                case .loaded:
                    contentView.characterCollection.isHidden = false
                    contentView.errorLabel.isHidden = true
                    contentView.progressIndicator.stopAnimating()
                case .loading:
                    contentView.characterCollection.isHidden = true
                    contentView.progressIndicator.startAnimating()
                    contentView.errorLabel.isHidden = true
                case .error:
                    contentView.characterCollection.isHidden = true
                    contentView.errorLabel.isHidden = false
                    contentView.progressIndicator.stopAnimating()
                }
            }
            .disposed(by: disposeBag)
    }
    
    @objc private func filterBarButtonItemTapped() {
        presenter.displayFilter()
    }
}

extension UINavigationBar {
    public func applyDefaultStyle() {
        prefersLargeTitles = true
        largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "AccentColor")]
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "AccentColor")]
        
    }
}
