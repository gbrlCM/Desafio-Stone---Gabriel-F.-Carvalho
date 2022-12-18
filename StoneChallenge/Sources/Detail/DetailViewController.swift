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
        contentView.statusContent.text = character.status.rawValue
        contentView.genderContent.text = character.gender
        contentView.speciesContent.text = character.species
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        CurrentEnv
            .image
            .fetch(character.image)
            .bind(to: contentView.imageView.rx.image)
            .disposed(by: disposeBag)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
