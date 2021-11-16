type t<'a> = 'a

@module("tone") @new external make: unit => t<'a> = "Synth"
@module("tone") external start: unit => Promise.t<'a> = "start"
@module("tone") external getDestination: unit => t<'a> = "getDestination"
@send external connect: (t<'a>, 'destination) => unit = "connect"
@send external disconnect: (t<'a>, 'destination) => unit = "disconnect"
@send external triggerAttack: (t<'a>, string) => unit = "triggerAttack"
@send external triggerRelease: unit => unit = "triggerRelease"

let startSynth = synth => start()->Promise.thenResolve(_ => synth->connect(getDestination()))

let stopSynth = synth => synth->disconnect(getDestination())

let triggerNote = (synth, note) => synth->triggerAttack(note)
let releaseNote = synth => synth->triggerRelease
