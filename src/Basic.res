// let defaultTuning = ["E2"]
let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]

@react.component
let make = (~onPlayNote, ~onUnmount, ~synthState) => {
  let (activeNote, setActiveNote) = React.useState(_ => None)

  React.useEffect0(() => {
    Some(
      () => {
        Js.log("HERE")
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
          | IsPlaying =>
            activeNote->Belt.Option.mapWithDefault(State.Button.Note.Inactive, activeNote =>
              activeNote === note ? Active : Inactive
            )
          }}
          key={note}
          onClick={_ => {
            onPlayNote(note)
            setActiveNote(_ => Some(note))
          }}>
          {React.string(note)}
        </Button.Base>
      })
      ->React.array}
    </div>
  </div>
}
