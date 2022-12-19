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
    private var disposeBag: DisposeBag
    let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
        self.contentView = DetailView()
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
        navigationItem.title = character.name
        contentView.header.setupContent(status: character.status, species: character.species, gender: character.gender)
        
        CurrentEnv
            .image
            .fetch(character.image)
            .bind(to: contentView.header.imageBinder)
            .disposed(by: disposeBag)
        
        CurrentEnv
            .api
            .fetchEpisodes(character.episode)
            .map { episodes in episodes.map(EpisodeCellViewModel.init(episode:))}
            .bind(to: contentView.episodesTable.rx.items(cellIdentifier: EpisodeCell.identifier, cellType: EpisodeCell.self)) { index, item, cell in
                cell.setup(with: item)
            }
            .disposed(by: disposeBag)
    }
}
