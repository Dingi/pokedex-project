//
//  PokemonDetailVC.swift
//  pokedex-project
//
//  Created by Janus Ringling on 23/02/2016.
//  Copyright © 2016 Janus Ringling. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImage: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var currentEvoImg:UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    @IBOutlet weak var evoTextLbl: UILabel!
    
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = pokemon.name.capitalizedString
        let image = UIImage(named: "\(pokemon.pokedexId)")
        mainImage.image = image
        currentEvoImg.image = image
        
        pokemon.downloadPokemonDetails{ ()->() in
            self.updateUI()
        }
    }
    func updateUI(){
        descriptionLbl.text = pokemon.description
        typeLbl.text = pokemon.type.capitalizedString
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        baseAttackLbl.text = pokemon.baseAttack
        
        if pokemon.nextEvoId == ""{
            
            nextEvoImg.hidden = true
            
        } else {
            nextEvoImg.hidden = false
            nextEvoImg.image = UIImage(named: pokemon.nextEvoId)
        }
        
        
        
        nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
        
        
        var str = "Next Evolution:"
        
        if pokemon.nextEvoLvl != "" {
            str += " - LVL \(pokemon.nextEvoLvl)"
        } else {
            str = "No Evolution"
        }
        evoTextLbl.text = "\(str)"
        
    }
    
    @IBAction func backButton(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

}
