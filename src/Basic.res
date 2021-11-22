let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]
let getListItemOffsetMembersByRelativePosition = (list, listItemIndex, offset) => {
  Js.Array.slice(~start=listItemIndex - offset, ~end_=listItemIndex + offset, list)
}
@react.component
let make = (~onPlayNote, ~onStopNote, ~onUnmount, ~synthState) => {
  let (activeNote, setActiveNote) = React.useState(_ => None)

  let onClickActiveNote = () => {
    onStopNote()
    setActiveNote(_ => None)
  }

  let onClickInactiveNote = note => {
    onPlayNote(note)
    setActiveNote(_ => Some(note))
  }

  let getIsClickedNoteActive = note =>
    activeNote->Belt.Option.mapWithDefault(false, activeNote => activeNote === note)

  React.useEffect0(() => {
    Some(
      () => {
        onUnmount()
      },
    )
  })

  <div className="w-full h-full flex justify-center items-center">
    <div className="grid grid-cols-6">
      {defaultTuning
      ->Belt.Array.map(note => {
        let targetIndex = Belt.Array.getIndexBy(Constants.baseNotes, n => note === n)
        switch targetIndex {
        | None => React.null
        | Some(index) =>
          <div className="flex flex-col items-center">
            {getListItemOffsetMembersByRelativePosition(Constants.baseNotes, index, 5)
            ->Belt.Array.map(note2 =>
              <button
                onClick={_ => onClickInactiveNote(note2)}
                className="p-2 border-2 flex items-center justify-center w-full cursor-pointer select-none">
                {note2->React.string}
              </button>
            )
            ->React.array}
          </div>
        }
      })
      ->React.array}
      // {Constants.baseNotes
      // ->Belt.Array.map(note => {
      //   <Button.Base
      //     buttonState={switch synthState {
      //     | State.IsNotPlaying => Inactive
      //     | State.IsPlaying =>
      //       switch getIsClickedNoteActive(note) {
      //       | true => Active
      //       | false => Inactive
      //       }
      //     }}
      //     key={note}
      //     onClick={_ =>
      //       switch synthState {
      //       | State.IsNotPlaying => onClickInactiveNote(note)
      //       | State.IsPlaying =>
      //         switch getIsClickedNoteActive(note) {
      //         | true => onClickActiveNote()
      //         | false => onClickInactiveNote(note)
      //         }
      //       }}>
      //     {React.string(note)}
      //   </Button.Base>
      // })
      // ->React.array}
    </div>
  </div>
}
