//
//  Pokémon.swift
//  pokedex-project
//
//  Created by Janus Ringling on 22/02/2016.
//  Copyright © 2016 Janus Ringling. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _baseAttack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvoId: String!
    private var _nextEvoLvl: String!
    private var _pokemonUrl: String!
    
    
    var name: String{
        
        get{
            if _name == nil {
                _name = ""
            }
            return _name
        }
    }
    
    var pokedexId: Int{
        
        get{
            if _pokedexId == nil {
                _pokedexId = 0
            } 
            return _pokedexId
        }
    }
    
    var description: String{
        get{
            if _description == nil{
                _description = ""
            }
            return _description
        }
        
    }
    
    var type: String {
        get{
            if _type == nil {
                _type = ""
            }
            return _type
        }
        
    }
    
    var defense: String{
        get{
            if _defense == nil {
                _defense = ""
            }
            return _defense
        }
    
    }
    
    var height: String{
        get{
            if _height == nil {
                _height = ""
            }
            return _height
        }
        
    }
    
    var weight: String{
        get{
            if _weight == nil {
                _weight = ""
            }
            return _weight
        }
        
    }
    
    var baseAttack: String{
        get{
            if _baseAttack == nil {
                _baseAttack = ""
            }
            return _baseAttack
        }
        
    }
    var nextEvoText: String{
        get{
            if _nextEvolutionTxt == nil {
                _nextEvolutionTxt = ""
            }
            return _nextEvolutionTxt
        }
        
    }
    
    var nextEvoId: String{
        get{
            if _nextEvoId == nil {
                _nextEvoId = ""
            }
            return _nextEvoId
        }
        
    }
    
    var nextEvoLvl: String{
        get{
            if _nextEvoLvl == nil {
                _nextEvoLvl = ""
            }
            return _nextEvoLvl
        }
        
    }
    
    
    init(name:String, pokedexId:Int){
        self._name = name
        self._pokedexId = pokedexId
        
        
        _pokemonUrl = "\(BASE_URL)\(POKEMON_URL)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete){
        
        let url = NSURL(string: _pokemonUrl)!
        
        Alamofire.request(.GET, url).responseJSON{
            Response in let result = Response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String{
                self._height = height
                }
                
                if let attack = dict["attack"] as? Int{
                    self._baseAttack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] where types.count > 0
                    {
                        if let name = types[0]["name"]{
                            self._type = name
                        }
                        
                        if types.count > 1 {
                            for var x = 1; x < types.count; x++ {
                                if let name = types[x]["name"]{
                                    self._type! += "/\(name.capitalizedString)"
                                }
                            }
                        }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String, String>] where descArr.count > 0{
                    if let url = descArr[0]["resource_uri"] {
                        let nsurl = NSURL(string: "\(BASE_URL)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON{
                            response in let desResult = response.result
                            if let descDict = desResult.value as? Dictionary<String, AnyObject>{
                                if let description = descDict["description"] as? String{
                                    self._description = description
                                }
                            }
                            completed()
                    }
                }else {
                    self._description = ""
                }
                
                    if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evolutions.count > 0{
                        if let to = evolutions[0]["to"] as? String{
                            if to.rangeOfString("mega") == nil{
                                
                                if let uri = evolutions[0]["resource_uri"] as? String{
                                    
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                                    
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString:"")
                                    
                                    self._nextEvoId = num
                                    self._nextEvolutionTxt = to
                                    
                                    
                                    if let lvl = evolutions[0]["level"] as? Int{
                                        self._nextEvoLvl = "\(lvl)"
                                    }
                                
                                }
                            }
                        }
                    }
                
                
            }
            
                
                
                
            }
        }
        
    }
    
}
