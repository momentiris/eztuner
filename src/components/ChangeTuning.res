@react.component
let make = (~onChangeTuning) => {
  <div className="relative w-full">
    <div className="absolute bg-white shadow-lg bottom-0 left-0 w-full border" />
    <ReactSelect
      onChange={onChangeTuning} options={Constants.Tuning.tunings} placeholder="Select tuning"
    />
  </div>
}
