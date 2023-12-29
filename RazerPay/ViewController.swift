import UIKit
import Razorpay


class ViewController: UIViewController {
    
    
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAmount: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    var razerPayKey = "rzp_test_Whae1nSIWphn9n"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func donateBtnTapped(_ sender: UIButton) {

       guard let name = txtName.text,
        let email = txtEmail.text,
        let phoneString = txtPhone.text,
        let phone = Int(phoneString),
        let amountString = txtAmount.text,
        let amount = Double(amountString) else{
            
                 return
        }
        
    startRazerPay(name: name, email: email,phone: phone,amount: amount)
      
    clearTextfield()
        
    }
    
    //Razerpay------------Start
    
    func startRazerPay(name:String,email:String,phone:Int,amount:Double)
    {
        let razerPay = RazorpayCheckout.initWithKey(razerPayKey, andDelegate:self)
        
        
        let options: [String:Any] = [
                    "name": name,
                    "description": "Charity Donation",
                    "image": "https://www.smilefoundationindia.org/wp-content/uploads/2022/09/SMILE-FOUNDATION-LOGO-e1662456150120-1.png",
                    "currency": "INR",
                    "amount": amount * 100,
                    "prefill": [
                        "email": email,
                        "contact": phone
                    ],
                    "theme": [
                        "color": "#000"
                    ]
                ]
                
        razerPay.open(options)
    }
    //Razerpay-------------End
    
    func clearTextfield()
    {
        txtName.text = ""
        txtEmail.text = ""
        txtPhone.text = ""
        txtAmount.text = ""

    }


    
    
}

extension ViewController: RazorpayPaymentCompletionProtocol {
    func onPaymentSuccess(_ payment_id: String) {
        print("Payment Success: \(payment_id)")
    }
    
    func onPaymentError(_ code: Int32, description str: String) {
        
        print("Payment Error: \(code) - \(str)")
    }
}

