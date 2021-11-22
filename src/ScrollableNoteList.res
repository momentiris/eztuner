module Placeholder = {
  @react.component
  let make = () => {
    <div className="flex flex-shrink-0 w-halfNote" />
  }
}

let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]
let getListItemOffsetMembersByRelativePosition = (list, listItemIndex, offset) => {
  Js.Array.slice(~start=listItemIndex - offset, ~end_=listItemIndex + offset, list)
}

@react.component
let make = () => {
  <div className="flex justify-center overflow-x-scroll w-note border-2 border-red-600">
    <div className="snappable overflow-visible relative flex flex-shrink-0 w-screen text-xl">
      // <Placeholder />
      // {defaultTuning
      // ->Belt.Array.mapWithIndex((index, note) => {
      //   getListItemOffsetMembersByRelativePosition(Constants.baseNotes, index, 5)->Js.log
      //   <div className=" w-note flex-shrink-0 border" key=note> {note->React.string} </div>
      // })
      // ->React.array}
      <Placeholder />
    </div>
  </div>
}
