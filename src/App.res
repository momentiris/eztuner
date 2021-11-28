let synth = Tone.make()
@react.component
let make = () => {
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

  <main className="flex flex-col items-center h-screen w-screen">
    <Layout>
      {switch url.path {
      | list{} =>
        <Basic onPlayNote onUnmount=onMute onStopNote=onMute synthState={state.synthState} />
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
