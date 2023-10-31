//
//  SporteatModel.swift
//  Gymestry
//
//  Created by Владислава on 18.09.23.
//

import SnapKit
import UIKit

enum SporteatModel {
    case protein
    case gainer
    case creatine
    case aminoAcids
    case weightLossDrugs
    case lCarnitine
    case vitamins
    case special
    case forJoints
    
    var title: String {
        switch self {
        case .protein:            return "Протеин"
        case .gainer:             return "Гейнер"
        case .creatine:           return "Креатин"
        case .aminoAcids:         return "Аминокислоты"
        case .weightLossDrugs:    return "Жиросжигатели"
        case .lCarnitine:         return "L-карнитин"
        case .vitamins:           return "Витамиы и минералы"
        case .special:            return "Специальные препараты"
        case .forJoints:          return "Средства для суставов и связок"
        }
    }
    //    var image: UIImage? {
    //        switch self {
    //        case .breast:       return UIImage(named: "")
    //        case .back:         return UIImage(named: "")
    //        case .legs:         return UIImage(named: "")
    //        case .glutes:
    //            <#code#>
    //        case .deltas:
    //            <#code#>
    //        case .biceps:
    //            <#code#>
    //        case .triceps:
    //            <#code#>
    //        case .forearm:
    //            <#code#>
    //        case .abs:
    //            <#code#>
    //        }
    //    }
    
    var info: String? {
        switch self {
        case .protein:            return load(file: "gainer")
        case .gainer:             return load(file: "gainer")
        case .creatine:           return load(file: "creatine")
        case .aminoAcids:         return load(file: "aminoAcids")
        case .weightLossDrugs:    return load(file: "weightloss")
        case .lCarnitine:         return load(file: "l-carnitine")
        case .vitamins:           return load(file: "vitamins")
        case .special:            return "Специальные препараты"
        case .forJoints:          return "Средства для суставов и связок"
        }
    }
    
    
    func load(file name:String) -> String {
        if let path = Bundle.main.path(forResource: name, ofType: "txt") {
            if let contents = try? String(contentsOfFile: path) {
                return contents
            } else {
                print("Error! - This file doesn't contain any text.")
            }
        } else {
            print("Error! - This file doesn't exist.")
        }
        return ""
    }
    
}
