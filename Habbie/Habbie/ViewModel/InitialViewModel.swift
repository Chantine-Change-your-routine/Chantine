//
//  InitialViewModel.swift
//  Chantine
//
//  Created by Beatriz Carlos on 25/11/20.
//

import UIKit

class InitialViewModel: InitialViewModelProtocol {
    var dataSource: [HabitBindingData]
    //    var habitRepository: HabitRepository
    
    static let initialViewModel = InitialViewModel()
    
    private init () {
        self.dataSource = []
        setMocking()
    }
    
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func getCellData(forIndex index: Int) -> HabitBindingData {
        return dataSource[index]
    }

    //    func biding() -> HabitBindingData {
    //        return nil
    //    }
    
    func setMocking() {
        self.dataSource.append(HabitBindingData(identifier: "Beber água", title: "Beber água", description: "Vamos ficar hidratados, meus rins agradecem.", imageId: 1, bgcolor: .blueLightColor, bgcolorDark: .blueDarkColor, progress: 45))
        self.dataSource.append(HabitBindingData(identifier: "Comer salada", title: "Comer salada", description: "Vamos comer salada para ficar saudável.", imageId: 3, bgcolor: .yellowLightColor, bgcolorDark: .yellowDarkColor, progress: 20))
        self.dataSource.append(HabitBindingData(identifier: "Fazer exercicios fisicos", title: "Fazer exercicios fisicos", description: "Vamos ser fitness.", imageId: 2, bgcolor: .greenLightColor, bgcolorDark: .greenDarkColor, progress: 2))
        self.dataSource.append(HabitBindingData(identifier: "Ler um livro.", title: "Ler um livro", description: "Ao ler 10 paginas por dia, voce pode ler até 3 livros no mês.", imageId: 4, bgcolor: .lavenderLightColor, bgcolorDark: .lavenderDarkColor, progress: 45))

    }
}
