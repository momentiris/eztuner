@react.component
let make = (~onChangeTuning) => {
  <div className="relative w-full max-w-sm">
    <div className=" rounded-md py-1 px-2r"> {"Change tuning"->React.string} </div>
    <div className="absolute bg-white shadow-lg bottom-0 left-0 w-full border" />
    <ReactSelect
      onChange={onChangeTuning} options={Constants.Tuning.tunings} placeholder="Select tuning"
    />
  </div>
}
