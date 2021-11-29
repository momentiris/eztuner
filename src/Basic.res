open Belt
let makeStringNoteMap = () =>
  Constants.Tuning.standard.value->Array.map(((gString, _)) => {
    Constants.baseNotes
    ->Array.getIndexBy(n => gString === n)
    ->Option.map(index => (
      gString,
      Constants.baseNotes |> Js.Array.slice(~start=index - 5, ~end_=index + 6) |> Array.reverse,
    ))
    ->Option.getWithDefault((gString, []))
  })

@react.component
let make = (~onPlayNote, ~onStopNote, ~onUnmount, ~synthState) => {
  let (activeTuning, setActiveTuning) = React.useState(_ => Constants.Tuning.standard.value)
  let (currentlyPlayingString, setCurrentlyPlayingString) = React.useState(_ => "")

  let stringNoteMap = React.useMemo0(makeStringNoteMap)

  let onSelectNote = (string, note) =>
    setActiveTuning(currentTuning =>
      currentTuning->Array.map(((s, n)) => s === string ? (s, note) : (s, n))
    )

  let getIsActiveNote = (gString, note) =>
    activeTuning->Array.getBy(((s, n)) => s === gString && n === note)->Option.isSome

  let getIsGStringActive = gString => currentlyPlayingString === gString

  let onPlayGuitarString = gString =>
    activeTuning
    ->Belt.Array.getBy(s => s->fst === gString)
    ->Option.map(str => {
      setCurrentlyPlayingString(_ => gString)
      str->snd->onPlayNote
    })
    ->ignore

  React.useEffect0(() => {
    Some(
      () => {
        onUnmount()
      },
    )
  })

  let onChangeTuning = (tuning: Constants.Tuning.t) => {
    setActiveTuning(_ => tuning.value)
  }

  <div className="w-full max-h-full flex flex-col max-w-lg mx-auto my-auto">
    <div className="pb-2"> <ChangeTuning onChangeTuning={onChangeTuning} /> </div>
    <div className="grid grid-cols-6 w-full border-dashed justify-items-center pt-2 pb-1">
      {Constants.Tuning.standard.value
      ->Array.map(((s, _)) =>
        <div key=s className="select-none text-sm text-accentlight last:lowercase">
          {s->Js.String2.substring(~from=0, ~to_=1)->React.string}
        </div>
      )
      ->React.array}
    </div>
    <div className="grid grid-cols-6 border-t border-l border-accentlight border-dashed w-full">
      {stringNoteMap
      ->Array.map(((s, notes)) =>
        <div key=s className="flex flex-col items-center">
          {notes
          ->Array.map(n => {
            <div key=n className="border-b border-r border-accentlight border-dashed w-full">
              <NoteListItem
                note=n isActive={getIsActiveNote(s, n)} onClick={_ => onSelectNote(s, n)}
              />
            </div>
          })
          ->React.array}
        </div>
      )
      ->React.array}
    </div>
    <div className="grid grid-cols-6 w-full border-dashed justify-items-center gap-2 pt-4">
      {Constants.Tuning.standard.value
      ->Array.map(((s, _)) =>
        <Button.Base
          isActive={synthState === State.IsPlaying && getIsGStringActive(s)}
          key=s
          onClick={_ => onPlayGuitarString(s)}>
          <span className="w-4">
            {synthState === State.IsPlaying && getIsGStringActive(s)
              ? <Icons.Stop />
              : <Icons.Play />}
          </span>
        </Button.Base>
      )
      ->React.array}
    </div>
  </div>
}
