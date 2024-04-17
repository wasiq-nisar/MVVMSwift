//
//  HomeViewModel.swift
//  MVVMSwift
//
//  Created by Muhammad Wasiq  on 15/04/2024.
//

import Foundation

//enum Types: Int, CaseIterable {
//    case all
//    case monsters
//    case spell
//    case trap
//
//    var name: String {
//        switch self {
//        case .all: return "All"
//        case .monsters: return "Monsters"
//        case .spell: return "Spell"
//        case .trap: return "Trap"
//        }
//    }
//}


class HomeViewModel {
    // MARK: - Variables
    weak var delegate: RequestDelegate?
    
    private var state: ViewState {
        didSet {
            self.delegate?.didUpdate(with: state)
        }
    }
    private var cards: [Card] = []
//    private var filteredCards: [Card] = []
//    private var selectedType: Types = .all {
//        didSet {
//            self.filterData()
//        }
//    }
    
    init() {
        self.state = .idle
    }
}

// MARK: - DataSource
extension HomeViewModel {
    var numberOfItems: Int {
        cards.count
    }
    
    func getInfo(for index: Int) -> (name: String, type: String, desc: String, imageURL: String?) {
        let card = cards[index]
        return (name: card.name, type: card.type, desc: card.desc, imageURL: card.cardImages.first?.imageURL)
    }
}

// MARK: - Services
extension HomeViewModel {
    func loadData() {
        self.state = .loading
        CardService.getAllCards { result in
            switch result {
            case let .success(cards):
                self.cards = cards
                self.state = .success
            case let .failure(error):
                self.cards = []
                self.state = .error(error)
            }
        }
    }
}
