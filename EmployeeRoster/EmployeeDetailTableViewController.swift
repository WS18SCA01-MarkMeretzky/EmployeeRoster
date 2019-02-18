
import UIKit;

class EmployeeDetailTableViewController:
    UITableViewController,
    UITextFieldDelegate,
    EmployeeTypeDelegate {   //p. 725, step 3, bullet 5
    
    var isEditingBirthday: Bool = false {   //p. 722, step 1, bullet 2
        didSet {
            tableView.performBatchUpdates(nil);
            //tableView.beginUpdates();
            //tableView.endUpdates();
        }
    }
    
    var employee: Employee? = nil;
    var employeeType: EmployeeType? = nil;   //p. 725, step 3, bullet 6

    struct PropertyKeys {
        static let unwindToListIndentifier = "UnwindToListSegue";
    }
    
    @IBOutlet weak var nameTextField: UITextField!;
    @IBOutlet weak var dobLabel: UILabel!;
    @IBOutlet weak var dobDatePicker: UIDatePicker!;
    @IBOutlet weak var employeeTypeLabel: UILabel!;
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        updateView();
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {   //p. 725, step 3, bullet 5
        guard let employeeTypeTableViewController: EmployeeTypeTableViewController = segue.destination as? EmployeeTypeTableViewController else {
            return;
        }
        employeeTypeTableViewController.delegate = self;
    }
    
    func updateView() {
        if let employee: Employee = employee {
            navigationItem.title = employee.name;
            nameTextField.text = employee.name;
            let dateFormatter: DateFormatter = DateFormatter();
            dateFormatter.dateStyle = .medium;
            dobLabel.text = dateFormatter.string(from: employee.dateOfBirth);
            dobLabel.textColor = .black;
            employeeTypeLabel.text = employee.employeeType.description();
            employeeTypeLabel.textColor = .black;
        } else {
            navigationItem.title = "New Employee";
        }
    }
    
    func format(date: Date) -> String {   //p. 723, step 1, bullet 5
        let dateFormatter: DateFormatter = DateFormatter();
        dateFormatter.dateStyle = .medium;
        return dateFormatter.string(from: date);
    }
    
    // MARK: - @IBActions
    
    @IBAction func dobValueChanged(_ sender: UIDatePicker) {   //p. 723, step 1, bullet 6
        dobLabel.text = format(date: sender.date);
    }
    
    @IBAction func saveButtonTapped(_ sender: Any) {
        if let name: String = nameTextField.text,
            let employeeType: EmployeeType = employeeType {   //p. 725, step 3, bullet 8
            //p. 723, step 1, bullet 7
            employee = Employee(name: name, dateOfBirth: dobDatePicker.date, employeeType: employeeType);
            performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self);
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        employee = nil;
        performSegue(withIdentifier: PropertyKeys.unwindToListIndentifier, sender: self);
    }
    
    //MARK: - UITableViewDelegate
    //p. 722, step 1, bullet 3
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (0, 2):
            return isEditingBirthday ? dobDatePicker.frame.height : 0;
        default:
            return 44.0;
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //p. 722, step 1, bullet 4
        tableView.deselectRow(at: indexPath, animated: true);
        if indexPath.row == 1 {
            isEditingBirthday = !isEditingBirthday;
            dobLabel.textColor = .black;
            dobLabel.text = format(date: dobDatePicker.date);
        }
    }
    
    // MARK: - Text Field Delegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false;
    }
    
    //MARK: - EmployeeTypeDelegate

    func didSelect(employeeType: EmployeeType) { //p. 725, step 3, bullet 5
        self.employeeType = employeeType;        //p. 725, step 3, bullet 7
        employeeTypeLabel.textColor = .black;
        employeeTypeLabel.text = employeeType.description();
    }
}
