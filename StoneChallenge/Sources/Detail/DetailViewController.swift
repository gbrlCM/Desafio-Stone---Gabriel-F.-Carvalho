//
//  DetailViewController.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 17/12/22.
//

import UIKit
import RxSwift

class DetailViewController: UIViewController {
    
    private let contentView: DetailView
    private let presenter: DetailPresenterProcotol
    private var disposeBag: DisposeBag
    
    init(presenter: DetailPresenterProcotol) {
        self.contentView = DetailView()
        self.presenter = presenter
        self.disposeBag = DisposeBag()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindNavigationTitle()
        bindEpisodeTable()
        bindHeader()
        presenter.viewDidLoad()
        

    }
    
    private func bindNavigationTitle() {
        presenter
            .viewModel
            .map(\.title)
            .observe(on: MainScheduler.instance)
            .bind(with: self) { viewController, title in
                viewController.navigationItem.title = title
            }
            .disposed(by: disposeBag)
    }
    
    private func bindEpisodeTable() {
        presenter
            .viewModel
            .map(\.episodeCells)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .bind(to: contentView.episodesTable.rx.items(cellIdentifier: EpisodeCell.identifier, cellType: EpisodeCell.self)) { index, item, cell in
                cell.setup(with: item)
            }
            .disposed(by: disposeBag)
    }
    
    private func bindHeader() {
        presenter
            .viewModel
            .map(\.header)
            .observe(on: MainScheduler.instance)
            .bind(with: contentView) { view, viewModel in
                view.header.setup(with: viewModel)
            }
            .disposed(by: disposeBag)
        
        presenter
            .viewModel
            .map(\.header.image)
            .observe(on: MainScheduler.instance)
            .bind(to: contentView.header.imageBinder)
            .disposed(by: disposeBag)
    }
}
