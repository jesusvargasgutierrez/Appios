import SwiftUI
import UIKit

class ReservationsclassView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var subject: [String] = []
    var schedule: [String] = []
    let picker = UIPickerView()
    let selectmat = UITextField()
    let selectvesp = UITextField()
    let selectypesubject = UITextField()
    let btnsend = UIButton()
    let labeltypesub = UILabel()
    let labelschedule = UILabel()
    let labelschedulev = UILabel()
    var subjects: [Subjects] = []
    var schedules: [Schedules] = []
    
    var campoActivo: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        super.viewDidLoad()
           view.backgroundColor = .white
           //configurarUI()
        WebServiceApi.shared.gettypesubject(){result in
            DispatchQueue.main.async {
                switch result{
                    case .success(let response):
                        //print("Respuesta exitosa: \(response)")

                        self.subjects = response
                        self.subject = self.subjects.map { $0.description }
                        self.picker.reloadAllComponents()
                    case .failure(let error):
                        print("Error de red al registrar: \(error.localizedDescription)")
                }
            }
        }
        
        WebServiceApi.shared.getschedules(){result in
            DispatchQueue.main.async {
                switch result{
                    case .success(let response):
                        //print("Respuesta exitosa: \(response)")

                        self.schedules = response
                        self.schedule = self.schedules.map { $0.description }
                        self.picker.reloadAllComponents()
                    case .failure(let error):
                        print("Error de red al registrar: \(error.localizedDescription)")
                }
            }
        }
        
        labeltypesub.text = "Tipo de clase"
        labelschedule.text = "Horario matutino"
        labelschedulev.text = "Horario Vespertino"
    
        selectypesubject.placeholder = "Selecciona un Tipo de clase"
        selectypesubject.borderStyle = .roundedRect
        selectypesubject.translatesAutoresizingMaskIntoConstraints = false
        selectypesubject.tintColor = .clear
        selectypesubject.inputAssistantItem.leadingBarButtonGroups = []
        selectypesubject.inputAssistantItem.trailingBarButtonGroups = []

        selectypesubject.isUserInteractionEnabled = true
        selectypesubject.delegate = self
        view.addSubview(labeltypesub)
        view.addSubview(selectypesubject)

        picker.delegate = self
        picker.dataSource = self
        selectypesubject.inputView = picker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(cerrarSelector))
        toolbar.setItems([done], animated: false)
        selectypesubject.inputAccessoryView = toolbar
        
        //Comienza selector de horarios matutinos
        
        selectmat.placeholder = "Selecciona horario"
        selectmat.borderStyle = .roundedRect
        selectmat.translatesAutoresizingMaskIntoConstraints = false
        selectmat.tintColor = .clear
        selectmat.inputAssistantItem.leadingBarButtonGroups = []
        selectmat.inputAssistantItem.trailingBarButtonGroups = []

        selectmat.isUserInteractionEnabled = true
        selectmat.delegate = self
        view.addSubview(selectmat)

        picker.delegate = self
        picker.dataSource = self
        selectmat.inputView = picker
        
        let toolbarmat = UIToolbar()
        toolbarmat.sizeToFit()
        let donemat = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(cerrarSelector))
        toolbarmat.setItems([donemat], animated: false)
        selectmat.inputAccessoryView = toolbarmat
        
        //Comienza selector de horarios vespertido
        
        selectvesp.placeholder = "Selecciona horario"
        selectvesp.borderStyle = .roundedRect
        selectvesp.translatesAutoresizingMaskIntoConstraints = false
        selectvesp.tintColor = .clear
        selectvesp.inputAssistantItem.leadingBarButtonGroups = []
        selectvesp.inputAssistantItem.trailingBarButtonGroups = []

        selectvesp.isUserInteractionEnabled = true
        selectvesp.delegate = self
        view.addSubview(selectvesp)

        picker.delegate = self
        picker.dataSource = self
        selectvesp.inputView = picker
        
        let toolbarvesp = UIToolbar()
        toolbarvesp.sizeToFit()
        let donevesp = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(cerrarSelector))
        toolbarmat.setItems([donevesp], animated: false)
        selectmat.inputAccessoryView = toolbarmat
        
        //Comienza botton de enviar
        
        btnsend.setTitle("Reservar", for: .normal)
        btnsend.backgroundColor = .blue
        btnsend.layer.cornerRadius = 10
        view.addSubview(btnsend)
        
        let stack = UIStackView(arrangedSubviews:[
                labeltypesub
                ,selectypesubject
                ,labelschedule
                ,selectmat
                ,labelschedulev
                ,selectvesp
                ,btnsend
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)
        
        //para mostrar en view

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        /*Button(
            action:{
                print("click")
            },
            label:{
                Text("Enviar")
                    .foregroundColor(.white)
                    .frame(width: 80,height: 50)
                    .background(.purple)
                    .cornerRadius(10)
            }
        )*/
    }

    @objc func cerrarSelector() {
        selectypesubject.resignFirstResponder()
        selectmat.resignFirstResponder()
        selectvesp.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false // bloquear entrada manual
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        campoActivo = textField
        picker.reloadAllComponents()
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if campoActivo == selectypesubject {
            return subject.count
        } else if campoActivo == selectmat {
            return schedule.count
        }else if campoActivo == selectvesp {
            return schedule.count
        } else {
            return 0
        }
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if campoActivo == selectypesubject {
            return subject[row]
        } else if campoActivo == selectmat {
            return schedule[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if campoActivo == selectypesubject {
            selectypesubject.text = subject[row]
            let idSeleccionado = subjects[row].id
            print("ID seleccionado: \(idSeleccionado)")
        } else if campoActivo == selectmat {
            selectmat.text = schedule[row]
            let idSeleccionado = schedules[row].id
            print("ID seleccionado: \(idSeleccionado)")
        } else if campoActivo == selectvesp {
            selectvesp.text = schedule[row]
           let idSeleccionado = schedules[row].id
           print("ID seleccionado: \(idSeleccionado)")
       }
    }
}

struct SelectorViewRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ReservationsclassView {
        return ReservationsclassView()
    }

    func updateUIViewController(_ uiViewController: ReservationsclassView, context: Context) {
        // no necesitas actualizar nada aquí por ahora
    }
}

struct SelectorViewRepresentable_Previews: PreviewProvider {
    static var previews: some View {
        SelectorViewRepresentable()
    }
}
