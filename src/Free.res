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
  ~synthState: State.synthState,
  ~triggerAttack,
  ~onUnmount,
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
          Js.log("note")
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
    switch synthState {
    | IsPlaying => onMute()
    | _ => onUnmute()
    }->ignore

  React.useEffect1(_ => {
    switch userState {
    | HasInteracted => initObserver()
    | _ => None
    }
  }, [userState])

  React.useEffect0(() => {
    Some(
      () => {
        onUnmount()
      },
    )
  })

  <div className="w-full flex flex-col justify-center items-center flex-grow font-main">
    <div className="w-8 mb-4 text-accentlight"> <Icons.Arrow /> </div>
    <div className="overflow-x-visible flex justify-center mb-12">
      <div
        ref={containerRef->ReactDOM.Ref.domRef}
        className="flex justify-center overflow-x-visible w-note  ">
        <div className="snappable overflow-x-scroll flex flex-shrink-0 w-screen text-xl pb-6">
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
    </div>
    <div className="max-w-xs w-full text-accentlight">
      <Button.Base
        buttonState={synthState === IsPlaying ? Active : Inactive}
        onClick={_ => onPlayClick()}
        onMouseDown={_ => onUserInteraction()}>
        {(synthState === IsPlaying ? "Stop" : "Play")->React.string}
      </Button.Base>
    </div>
  </div>
}
