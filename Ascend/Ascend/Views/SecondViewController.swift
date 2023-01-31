//
//  SecondViewController.swift
//  Ascend
//
//  Created by Fahad Ahmed Usmani on 31/01/2023.
//

import UIKit
import Combine

class SecondViewController: UIViewController {
    
    @IBOutlet weak var counterLabel: UILabel!
    var viewModel : ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupPublisher()
    }
    
    private func setupPublisher(){
        let _ : AnyCancellable? = viewModel?.$counter
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
            
                self?.counterLabel.text = "Counter : \(String(describing: value))"
        })
    }
}
