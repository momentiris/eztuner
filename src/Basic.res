let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]

@react.component
let make = (~onPlayNote, ~onStopNote, ~onUnmount, ~synthState) => {
  let (activeNote, setActiveNote) = React.useState(_ => "")
  let (activeString, setActiveString) = React.useState(_ => "")

  let onClickActiveNote = () => {
    onStopNote()
    setActiveNote(_ => "")
  }

  let onClickInactiveNote = (string, note) => {
    onPlayNote(note)
    setActiveNote(_ => note)
    setActiveString(_ => string)
  }

  let getIsClickedNoteActive = (gString, note) => activeNote === note && activeString === gString

  React.useEffect0(() => {
    Some(
      () => {
        onUnmount()
      },
    )
  })

  open Belt
  let stringNoteMap = React.useMemo0(() =>
    defaultTuning->Array.map(gString => {
      Constants.baseNotes
      ->Array.getIndexBy(n => gString === n)
      ->Option.map(index => (
        gString,
        Js.Array.slice(~start=index - 5, ~end_=index + 6, Constants.baseNotes),
      ))
      ->Option.getWithDefault((gString, []))
    })
  )

  <div className="w-full h-full flex justify-center items-center flex-col px-4">
    <div className="grid grid-cols-6 border-t border-l border-dashed justify-items-center w-full">
      {stringNoteMap
      ->Array.map(((s, notes)) =>
        <div key=s className="flex flex-col items-center">
          {notes
          ->Array.map(n => {
            <NoteListItem
              key=n
              note=n
              isActive={getIsClickedNoteActive(s, n)}
              onClick={_ => onClickInactiveNote(s, n)}
            />
          })
          ->React.array}
        </div>
      )
      ->React.array}
    </div>
    <div className="grid grid-cols-6 w-full border-t border-l border-dashed justify-items-center">
      <div> {"x"->React.string} </div>
      <div> {"x"->React.string} </div>
      <div> {"x"->React.string} </div>
      <div> {"x"->React.string} </div>
      <div> {"x"->React.string} </div>
      <div> {"x"->React.string} </div>
    </div>
  </div>
}
