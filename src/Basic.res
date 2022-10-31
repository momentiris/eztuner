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

  <div className="w-full h-full flex flex-col mx-auto">
    <div
      className="flex flex-col gap-4 md:flex-row md:justify-between w-full md:items-center px-8 md:pt-6 py-4">
      <h1 className="text-3xl font-bold"> {"eztuner.app"->React.string} </h1>
      <div className="w-full md:max-w-sm pt-2">
        <ChangeTuning onChangeTuning={onChangeTuning} />
      </div>
    </div>
    <div className="grid grid-cols-6 w-full justify-items-center pb-1 pt-4">
      {Constants.Tuning.standard.value
      ->Array.map(((s, _)) =>
        <div key=s className="select-none text-sm text-gray-500 last:lowercase">
          {s->Js.String2.substring(~from=0, ~to_=1)->React.string}
        </div>
      )
      ->React.array}
    </div>
    <div className="grid grid-cols-6 w-full border-l border-t h-full">
      {stringNoteMap
      ->Array.map(((s, notes)) =>
        <div key=s className="flex flex-col items-center h-full">
          {notes
          ->Array.map(n => {
            <NoteListItem
              key={n} note=n isActive={getIsActiveNote(s, n)} onClick={_ => onSelectNote(s, n)}
            />
          })
          ->React.array}
        </div>
      )
      ->React.array}
    </div>
    <div className="grid grid-cols-6 w-full justify-items-stretch">
      {Constants.Tuning.standard.value
      ->Array.map(((s, _)) =>
        <Button.Base
          isActive={synthState === State.IsPlaying && getIsGStringActive(s)}
          key=s
          onClick={_ => onPlayGuitarString(s)}>
          <span className="w-3">
            {synthState === State.IsPlaying && getIsGStringActive(s)
              ? <Icons.Stop size="18" />
              : <Icons.Play size="18" />}
          </span>
        </Button.Base>
      )
      ->React.array}
    </div>
  </div>
}
