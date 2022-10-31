@react.component
let make = (~onChangeTuning) => {
  <ReactSelect
    onChange={onChangeTuning} options={Constants.Tuning.tunings} placeholder="Select tuning"
  />
}
