import SwiftUI
import UIKit

class ReservationsCourtsView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    var court: [String] = []
    var schedule: [String] = []
    let picker = UIPickerView()
    let selectcourts = UITextField()
    let btnsend = UIButton()
    let labelcourt = UILabel()
    let datepicker = UIDatePicker()
    let labeldate = UILabel()
    let labelschedule = UILabel()
    let pickerschedule = UIDatePicker()
    var courts: [Courts] = []
    var campoActivo: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        super.viewDidLoad()
           view.backgroundColor = .white
           //configurarUI()
        WebServiceApi.shared.getcourts(){result in
            DispatchQueue.main.async {
                switch result{
                    case .success(let response):
                        //print("Respuesta exitosa: \(response)")

                        self.courts = response
                        self.court = self.courts.map { $0.description }
                        self.picker.reloadAllComponents()
                    case .failure(let error):
                        print("Error de red al registrar: \(error.localizedDescription)")
                }
            }
        }
        
        labelcourt.text = "Cancha"
        labeldate.text = "Fecha"
        labelschedule.text = "Hora"
    
        selectcourts.placeholder = "Selecciona cancha"
        selectcourts.borderStyle = .roundedRect
        selectcourts.translatesAutoresizingMaskIntoConstraints = false
        selectcourts.tintColor = .clear
        selectcourts.inputAssistantItem.leadingBarButtonGroups = []
        selectcourts.inputAssistantItem.trailingBarButtonGroups = []

        selectcourts.isUserInteractionEnabled = true
        selectcourts.delegate = self
        view.addSubview(labelcourt)
        view.addSubview(selectcourts)

        picker.delegate = self
        picker.dataSource = self
        selectcourts.inputView = picker

        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let done = UIBarButtonItem(title: "Listo", style: .done, target: self, action: #selector(cerrarSelector))
        toolbar.setItems([done], animated: false)
        selectcourts.inputAccessoryView = toolbar
        
        //Comienza control de fecha
        datepicker.datePickerMode = .date
        datepicker.contentHorizontalAlignment = .fill
        datepicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datepicker)
        
        //Comienza control de horario
        pickerschedule.datePickerMode = .time
        pickerschedule.contentHorizontalAlignment = .fill
        pickerschedule.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pickerschedule)
        
        //Comienza botton de enviar
        btnsend.setTitle("Reservar", for: .normal)
        btnsend.backgroundColor = .blue
        btnsend.layer.cornerRadius = 10
        btnsend.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        view.addSubview(btnsend)
        
        let stack = UIStackView(arrangedSubviews:[
                labelcourt
                ,selectcourts
                ,labeldate
                ,datepicker
                ,labelschedule
                ,pickerschedule
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
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            datepicker.widthAnchor.constraint(equalTo: stack.widthAnchor),
            pickerschedule.widthAnchor.constraint(equalTo: stack.widthAnchor)
        ])
    }

    @objc func cerrarSelector() {
        selectcourts.resignFirstResponder()
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
        if campoActivo == selectcourts {
            return court.count
        } else {
            return 0
        }
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if campoActivo == selectcourts {
            return court[row]
        }
        return nil
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if campoActivo == selectcourts {
            selectcourts.text = court[row]
            let idSeleccionado = courts[row].id
            print("ID seleccionado: \(idSeleccionado)")
        }
    }
    
    @objc func handleSend() {
        // Obtener cancha seleccionada
        let cancha = selectcourts.text ?? ""

        // Obtener fecha seleccionada
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let fecha = formatter.string(from: datepicker.date)

        // Obtener hora seleccionada
        formatter.dateFormat = "HH:mm"
        let hora = formatter.string(from: pickerschedule.date)

        print("Cancha: \(cancha), Fecha: \(fecha), Hora: \(hora)")
    }
}

struct SelectorViewCourts: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> ReservationsCourtsView {
        return ReservationsCourtsView()
    }

    func updateUIViewController(_ uiViewController: ReservationsCourtsView, context: Context) {
        // no necesitas actualizar nada aquí por ahora
    }
}

struct SelectorViewCourts_Previews: PreviewProvider {
    static var previews: some View {
        SelectorViewCourts()
    }
}

