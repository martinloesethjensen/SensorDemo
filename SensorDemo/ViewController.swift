import UIKit
import CoreMotion
import AudioToolbox // library that imports AudioServicePlayAlertSound

class ViewController: UIViewController {
    
    var motionManager = CMMotionManager()
    var queue = OperationQueue()
    
    @IBOutlet weak var slider: UISlider!
    
    @IBOutlet weak var succedLabel: UITextField!
    
    @IBOutlet weak var cancelTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        succedLabel.isHidden = true
    }
    
    @IBAction func btnClicked(_ sender: Any) {
        succedLabel.isHidden = true
        cancelTextField.isHidden = true
        motionManager.startDeviceMotionUpdates(to: queue) { (motion, error) in DispatchQueue.main.async {
                self.slider.value = Float((motion?.attitude.roll ?? 0 ) * 1.4)
            
                print(self.slider.value)
            
                if self.slider.value == 1.0 {
                    self.succedLabel.isHidden = false
                    self.motionManager.stopDeviceMotionUpdates()
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate); // vibrates when payment has succeded 
                }
                
                if self.slider.value == -1.0 {
                    self.cancelTextField.isHidden = false
                    self.motionManager.stopDeviceMotionUpdates()
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
                }
            }
        }
    }
}
