//
//  PokeCell.swift
//  pokedex-project
//
//  Created by Janus Ringling on 22/02/2016.
//  Copyright © 2016 Janus Ringling. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
    }
    
    
    func configureCell(pokemon:Pokemon){
        self.pokemon = pokemon
        
        cellLabel.text = pokemon.name.capitalizedString
        cellImg.image = UIImage(named: "\(self.pokemon.pokedexId)")
    }
    

}
