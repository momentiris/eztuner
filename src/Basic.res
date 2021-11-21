let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]

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

  <div className="w-full h-full flex justify-center items-center px-6">
    <div className="flex flex-grow flex-col justify-center items-center max-w-sm gap-6 w-full">
      {defaultTuning
      ->Belt.Array.map(note => {
        <Button.Base
          buttonState={switch synthState {
          | State.IsNotPlaying => Inactive
          | State.IsPlaying =>
            switch getIsClickedNoteActive(note) {
            | true => Active
            | false => Inactive
            }
          }}
          key={note}
          onClick={_ =>
            switch synthState {
            | State.IsNotPlaying => onClickInactiveNote(note)
            | State.IsPlaying =>
              switch getIsClickedNoteActive(note) {
              | true => onClickActiveNote()
              | false => onClickInactiveNote(note)
              }
            }}>
          {React.string(note)}
        </Button.Base>
      })
      ->React.array}
    </div>
  </div>
}
