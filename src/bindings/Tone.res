type t<'a> = 'a

@module("tone") @new external make: unit => t<'a> = "Synth"
@module("tone") external start: unit => Promise.t<'a> = "start"
@module("tone") external getDestination: unit => t<'a> = "getDestination"
@send external connect: (t<'a>, 'destination) => unit = "connect"
@send external disconnect: (t<'a>, 'destination) => unit = "disconnect"
@send external triggerAttack: (t<'a>, string) => unit = "triggerAttack"
@send external triggerRelease: unit => unit = "triggerRelease"

let synth = make()

let startSynth = () => start()->Promise.thenResolve(_ => synth->connect(getDestination()))

let stopSynth = () => synth->disconnect(getDestination())

let triggerNote = note => synth->triggerAttack(note)
let releaseNote = _ => synth->triggerRelease
