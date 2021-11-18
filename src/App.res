@react.component
let make = () => {
  let synth = React.useMemo0(Tone.make)
  let url = RescriptReactRouter.useUrl()

  let (state, setState) = React.useState(_ => State.initialState)

  let onUnmute = () => {
    Tone.startSynth(synth)
    setState(state => {...state, synthState: IsPlaying})
  }

  let onMute = () => {
    Tone.stopSynth(synth)
    setState(state => {...state, synthState: IsNotPlaying})
  }

  let onUserInteraction = () => setState(state => {...state, userState: HasInteracted})

  let onPlayNote = note => {
    Tone.startSynth(synth)
    Tone.triggerAttack(synth, note)
    setState(_ => {userState: HasInteracted, synthState: IsPlaying})->ignore
  }

  <main className="flex flex-col items-center h-screen w-screen overflow-hidden">
    <Layout>
      {switch url.path {
      | list{} => <Basic onPlayNote synthState=state.synthState onUnmount=onMute />
      | list{"free"} =>
        <Free
          triggerAttack={Tone.triggerNote(synth)}
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
