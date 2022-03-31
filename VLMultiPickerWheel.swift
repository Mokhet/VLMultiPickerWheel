import SwiftUI

struct VLMultiPickerWheel: UIViewRepresentable
{
 @Binding var selections: [String]
 var data: [[String]]

 func makeCoordinator() -> VLMultiPickerWheel.Coordinator
 {
  Coordinator(self)
 }

 func makeUIView(context: UIViewRepresentableContext<VLMultiPickerWheel>) -> UIPickerView
 {
  let picker = UIPickerView(frame: .zero)

  picker.dataSource = context.coordinator
  picker.delegate = context.coordinator

  return picker
 }

 func updateUIView(_ view: UIPickerView, context: UIViewRepresentableContext<VLMultiPickerWheel>)
 {
  for i in 0..<selections.count
  {
   let idx = data[i].firstIndex(of: selections[i]) ?? 0
   view.selectRow(idx, inComponent: i, animated: false)
  }
 }

 class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate
 {
  var parent: VLMultiPickerWheel

  init(_ pickerView: VLMultiPickerWheel)
  {
   self.parent = pickerView
  }

  func numberOfComponents(in pickerView: UIPickerView) -> Int
  {
   return parent.data.count
  }

  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
  {
   return parent.data[component].count
  }

  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
  {
   return parent.data[component][row]
  }

  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
  {
   parent.selections[component] = parent.data[component][row]
  }
 }
}
