//
//  Pokémon.swift
//  pokedex-project
//
//  Created by Janus Ringling on 22/02/2016.
//  Copyright © 2016 Janus Ringling. All rights reserved.
//

import Foundation

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String{
        return _name
    }
    
    var podedexId: Int{
        return _pokedexId
    }
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
    }

}