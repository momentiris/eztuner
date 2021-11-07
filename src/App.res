@react.component
let make = () => {
  let url = RescriptReactRouter.useUrl()
  let (state, setState) = React.useState(_ => State.initialState)

  let onPlayNote = note => {
    switch state.userState {
    | HasInteracted => Tone.triggerNote(note)
    | _ =>
      Tone.startSynth()
      ->Promise.thenResolve(_ => {
        setState(state => {...state, userState: HasInteracted})
        Tone.triggerNote(note)
      })
      ->ignore
    }
  }

  let onUnmute = () =>
    Tone.startSynth()
    ->Promise.thenResolve(_ => setState(state => {...state, isPlaying: true}))
    ->ignore

  let onMute = () =>
    Tone.stopSynth()
    ->Promise.thenResolve(_ => setState(state => {...state, isPlaying: false}))
    ->ignore

  let triggerAttack = note => {
    note->Js.log
    Tone.triggerNote(note)
  }

  let onUserInteraction = () => {
    setState(state => {...state, userState: HasInteracted})
  }

  <main className="flex flex-col items-center h-screen w-screen overflow-hidden">
    <Layout>
      {switch url.path {
      | list{} => <Basic onPlayNote />
      | list{"free"} =>
        <Free
          onUserInteraction
          userState=state.userState
          isPlaying=state.isPlaying
          onMute
          onUnmute
          triggerAttack
        />
      | _ => <div />
      }}
    </Layout>
  </main>
}
