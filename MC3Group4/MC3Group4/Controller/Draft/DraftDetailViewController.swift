import UIKit

class DraftDetailViewController: UIViewController {
    
    
    @IBOutlet weak var schoolNameLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var needsLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var notesLabel: UILabel!
    
    
    var isNewDraft: Bool!
    var currentDraft: PostModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    
}
