//
//  OrderConfirmationViewController.swift
//  OrderApp
//
//  Created by Yuki Tsukada on 2021/01/18.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    let minutesToPrepare: Int
    @IBOutlet var confirmationLabel: UILabel!
    
    
    init?(coder: NSCoder, minutesToPrepare: Int) {
        self.minutesToPrepare = minutesToPrepare
        super.init(coder: coder)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        confirmationLabel.text = "Thank you for your order! Your wait time is approximately \(minutesToPrepare) minutes."
    }
    

    
//    @IBAction func unwindToOrderList(segue: UIStoryboardSegue) {
//        if segue.identifier == "dismissConfirmation" {
//            print("dismissConfirmation")
//            MenuController.shared.order.menuItems.removeAll()
//        }
//        
//    }
//    
//    @IBAction func dismissButtonTapped(_ sender: UIButton) {
//        print("dismissButtonTapped")
//        MenuController.shared.order.menuItems.removeAll()
//    }
    
    
    //    @IBAction func submitTapped(_ sender: Any) {
//        let orderTotal = MenuController.shared.order.menuItems.reduce(0.0) { (result, menuItem) -> Double in
//            return result + menuItem.price
//        }
//
//        let formattedTotal = MenuItem.priceFormatter.string(from: NSNumber(value: orderTotal)) ?? "\(orderTotal)"
//
//        let alertController = UIAlertController(title: "Confirm Order", message: "You are about to submit your order with a total of \(formattedTotal)", preferredStyle: .actionSheet)
//
//        alertController.addAction(UIAlertAction(title: "submit", style: .default, handler: { _ in
//            self.uploadOrder()
//
//        }))
//
//        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//
//        present(alertController, animated: true, completion: nil)
//    }
//
//    func uploadOrder() {
//        let menuIds = MenuController.shared.order.menuItems.map{$0.id}
//        MenuController.shared.submitOrder(forMenuIDs: menuIds) { (result) in
//            switch result {
//            case .success(let minutesToPrepare):
//                DispatchQueue.main.async {
//                    self.minutesToPrepareOrder = minutesToPrepare
//                    self.performSegue(withIdentifier: "confirmOrder", sender: nil)
//                }
//            case .failure(let error):
//                self.displayError(error, title: "Order Submittion Failed")
//            }
//        }
//    }
//
//    func displayError(_ error: Error, title: String) {
//        DispatchQueue.main.async {
//            let alert = UIAlertController(title: title, message: error.localizedDescription, preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "DIsmiss", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
