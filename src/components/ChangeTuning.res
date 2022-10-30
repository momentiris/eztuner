@react.component
let make = (~onChangeTuning) => {
  <div className="relative w-full">
    <ReactSelect
      onChange={onChangeTuning} options={Constants.Tuning.tunings} placeholder="Select tuning"
    />
  </div>
}
