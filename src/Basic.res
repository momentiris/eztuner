type noteSMap = array<(string, array<string>)>
let defaultTuning = [
  ("E2", "E2"),
  ("A2", "A2"),
  ("D3", "D3"),
  ("G3", "G3"),
  ("B3", "B3"),
  ("E4", "E4"),
]

open Belt
let makeStringNoteMap = () =>
  defaultTuning->Array.map(((gString, activeNote)) => {
    Constants.baseNotes
    ->Array.getIndexBy(n => gString === n)
    ->Option.map(index => (
      gString,
      Constants.baseNotes |> Js.Array.slice(~start=index - 5, ~end_=index + 6),
    ))
    ->Option.getWithDefault((gString, []))
  })

@react.component
let make = (~onPlayNote, ~onStopNote, ~onUnmount, ~synthState) => {
  let (activeTuning, setActiveTuning) = React.useState(_ => defaultTuning)
  let (currentlyPlayingString, setCurrentlyPlayingString) = React.useState(_ => "")

  let stringNoteMap = React.useMemo0(makeStringNoteMap)

  let onSelectNote = (string, note) =>
    setActiveTuning(currentTuning =>
      currentTuning->Array.map(((s, n)) => s === string ? (s, note) : (s, n))
    )

  let getIsNoteActive = (gString, note) =>
    switch activeTuning->Array.getBy(((s, n)) => s === gString && n === note) {
    | Some(_) => true
    | _ => false
    }

  let getIsGStringActive = gString => currentlyPlayingString === gString

  let onPlayGuitarString = gString =>
    activeTuning
    ->Belt.Array.getBy(x => x->fst === gString)
    ->Option.map(x => {
      setCurrentlyPlayingString(_ => gString)
      x->snd->onPlayNote
    })
    ->ignore

  React.useEffect0(() => {
    Some(
      () => {
        onUnmount()
      },
    )
  })

  <div className="w-full max-h-full flex flex-col items-center">
    <div className="grid grid-cols-6 w-full border-dashed justify-items-center max-w-lg pt-2 pb-1">
      {defaultTuning
      ->Array.map(((s, _)) =>
        <div key=s className="select-none text-sm text-accentlight last:lowercase">
          {s->Js.String2.substring(~from=0, ~to_=1)->React.string}
        </div>
      )
      ->React.array}
    </div>
    <div
      className="grid grid-cols-6 border-t border-l border-accentlight border-dashed w-full max-w-lg">
      {stringNoteMap
      ->Array.map(((s, notes)) =>
        <div key=s className="flex flex-col items-center">
          {notes
          ->Array.map(n => {
            <div key=n className="border-b border-r border-accentlight border-dashed w-full">
              <NoteListItem
                note=n isActive={getIsNoteActive(s, n)} onClick={_ => onSelectNote(s, n)}
              />
            </div>
          })
          ->React.array}
        </div>
      )
      ->React.array}
    </div>
    <div
      className="grid grid-cols-6 w-full  border-dashed justify-items-center max-w-lg gap-2 pt-4">
      {defaultTuning
      ->Array.map(((s, _)) =>
        <Button.Base isActive={getIsGStringActive(s)} key=s onClick={_ => onPlayGuitarString(s)}>
          {(synthState === State.IsPlaying && getIsGStringActive(s) ? "S" : "P")->React.string}
        </Button.Base>
      )
      // <div
      //   onClick={_ => onPlayGuitarString(s)}
      //   key=s
      //   className="py-2 px-4 border-red-500 border-2  flex items-center justify-center">
      //   {s->Js.String2.substring(~from=0, ~to_=1)->React.string}
      // </div>
      ->React.array}
    </div>
  </div>
}
