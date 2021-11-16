@react.component
let make = () => {
  let synth = React.useMemo0(Tone.make)
  let url = RescriptReactRouter.useUrl()

  let (state, setState) = React.useState(_ => State.initialState)

  let onPlayNote = note => {
    Tone.startSynth(synth)
    ->Promise.thenResolve(_ => {
      setState(_ => {userState: HasInteracted, synthState: IsPlaying})
      Tone.triggerNote(synth, note)
    })
    ->ignore
  }

  let onUnmute = () =>
    Tone.startSynth(synth)
    ->Promise.thenResolve(_ => setState(state => {...state, synthState: IsPlaying}))
    ->ignore

  let onMute = () => {
    Tone.stopSynth(synth)
    setState(state => {...state, synthState: IsNotPlaying})
  }

  let triggerAttack = note => Tone.triggerNote(synth, note)

  let onUserInteraction = () => {
    setState(state => {...state, userState: HasInteracted})
  }

  <main className="flex flex-col items-center h-screen w-screen overflow-hidden">
    <Layout>
      {switch url.path {
      | list{} => <Basic onPlayNote onUnmount=onMute />
      | list{"free"} =>
        <Free
          triggerAttack
          onUserInteraction
          onMute
          onUnmute
          onUnmount=onMute
          userState=state.userState
          synthState=state.synthState
        />
      | _ => <div />
      }}
    </Layout>
  </main>
}
