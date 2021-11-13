let defaultTuning = ["E2", "A2", "D3", "G3", "B3", "E4"]

@react.component
let make = (~onPlayNote) => {
  <div className="w-full h-full flex justify-center items-center text-light px-4">
    <div className="flex flex-grow flex-col justify-center items-center max-w-sm gap-6 w-full">
      {Belt.Array.map(defaultTuning, note => {
        <Button.PlayNote key={note} onClick={_ => onPlayNote(note)}>
          {React.string(note)}
        </Button.PlayNote>
      })->React.array}
    </div>
  </div>
}
