//
//  DetailView.swift
//  StoneChallenge
//
//  Created by Gabriel Ferreira de Carvalho on 17/12/22.
//

import UIKit

class DetailView: UIView {
    
    private(set) lazy var header: DetailViewHeader = {
        let h = DetailViewHeader()
        h.translatesAutoresizingMaskIntoConstraints = false
        return h
    }()
    
    private(set) lazy var episodesTable: UITableView = {
        let tv = UITableView(frame: .zero, style: .plain)
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.estimatedRowHeight = 60
        tv.register(EpisodeCell.self, forCellReuseIdentifier: EpisodeCell.identifier)
        return tv
    }()

    init() {
        super.init(frame: .zero)
        setupHierarchy()
        setupConstraints()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupHierarchy() {
        addSubview(header)
        addSubview(episodesTable)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            header.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            header.leadingAnchor.constraint(equalTo: leadingAnchor),
            header.trailingAnchor.constraint(equalTo: trailingAnchor),
            header.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
        ])
        
        let episodesTableConstraints: [NSLayoutConstraint] = [
            episodesTable.topAnchor.constraint(equalTo: header.bottomAnchor),
            episodesTable.leadingAnchor.constraint(equalTo: leadingAnchor),
            episodesTable.trailingAnchor.constraint(equalTo: trailingAnchor),
            episodesTable.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
        NSLayoutConstraint.activate(episodesTableConstraints)
    }
    
    private func setupStyle() {
        backgroundColor = .systemBackground
    }
}
