module Placeholder = {
  @react.component
  let make = () => {
    <div className="flex flex-shrink-0 w-halfNote" />
  }
}

@react.component
let make = (
  ~userState: State.userState,
  ~onUserInteraction,
  ~onMute,
  ~onUnmute,
  ~isPlaying,
  ~triggerAttack,
) => {
  let (activeNote, setActiveNote) = React.useState(_ => "C2")

  let containerRef = React.useRef(Js.Nullable.null)
  let noteRefs = Constants.baseNotes->Belt.Array.map(_ => React.createRef())

  let initObserver = () => {
    open Belt

    containerRef.current
    ->Js.Nullable.toOption
    ->Option.flatMap(node => {
      open IntersectionObserver

      let options = options(~root=node, ~threshold=0.5)
      let observer = make(entries => {
        entries
        ->Array.getBy(Entry.isIntersecting)
        ->Option.map(Entry.target)
        ->Option.map(el => {
          setActiveNote(_ => el.id)
          triggerAttack(el.id)
        })
        ->ignore
      }, options())

      noteRefs
      ->Array.keepMap(ref => ref.current->Js.Nullable.toOption)
      ->Array.forEach(observe(observer))

      Some(() => observer->disconnect)
    })
  }

  let onPlayClick = () =>
    switch isPlaying {
    | true => onMute()
    | _ => onUnmute()
    }->ignore

  React.useEffect1(_ => {
    switch userState {
    | HasInteracted => initObserver()
    | _ => None
    }
  }, [userState])

  <div className="w-full flex flex-col justify-center items-center flex-grow">
    <div className="w-8 mb-2 text-light"> <Icons.Arrow /> </div>
    <div
      ref={containerRef->ReactDOM.Ref.domRef}
      className="flex justify-center overflow-x-visible w-note">
      <div className="snappable overflow-x-auto flex flex-shrink-0 w-screen text-xl pb-4 mb-12">
        <Placeholder />
        {Constants.baseNotes
        ->Belt.Array.mapWithIndex((i, note) =>
          <Note
            key=note active={note == activeNote} note nodeRef={noteRefs[i]->ReactDOM.Ref.domRef}
          />
        )
        ->React.array}
        <Placeholder />
      </div>
    </div>
    <div className="max-w-xs">
      <Button.Unmute onClick={_ => onPlayClick()} onMouseDown={_ => onUserInteraction()}>
        {(isPlaying ? "Pause" : "Play")->React.string}
      </Button.Unmute>
    </div>
  </div>
}