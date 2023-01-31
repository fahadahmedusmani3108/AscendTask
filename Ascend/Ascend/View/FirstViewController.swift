//
//  ViewController.swift
//  Ascend
//
//  Created by Fahad Ahmed Usmani on 31/01/2023.
//

import UIKit
import Combine

class FirstViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var goButton: UIButton!
    @IBOutlet weak var listView: UICollectionView!
    
    var viewModel : ViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
        viewModel = ViewModel.init()
        setupPublisher()
    }


    @IBAction func didTappedGoButton(_ sender: Any) {
        viewModel?.updateCounter()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? SecondViewController{
            controller.viewModel = viewModel
        }
    }
}

//MARK:- Functions
extension FirstViewController{
    
    private func setupViews(){
        topView.layer.borderWidth = 1.0
        topView.layer.borderColor = UIColor.black.cgColor
        goButton.layer.cornerRadius = 5.0
    }
    
    private func setupPublisher(){
       
        let _ : AnyCancellable? = viewModel?.$counter
            .receive(on: DispatchQueue.main)
            .subscribe(on: DispatchQueue.global())
            .sink(receiveValue: { [weak self] value in
                self?.listView.reloadData()
            })
    }
}


//MARK:- Delegates
extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource{
  

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let counter = viewModel?.counter, counter > 0{
            return counter
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customCell", for: indexPath) as? CustomCollectionViewCell{
            let count =  viewModel!.counter > 0 ? "\(indexPath.row + 1)" : "\(indexPath.row)"
            cell.textLabel.text = "Counter : \(count)"
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
    
}
