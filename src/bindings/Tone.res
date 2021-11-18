type t<'a> = 'a

@module("tone") @new external make: unit => t<'a> = "Synth"
@module("tone") external start: unit => Promise.t<'a> = "start"
@module("tone") external getDestination: unit => 'destination = "getDestination"
@send external connect: (t<'a>, 'destination) => unit = "connect"
@send external disconnect: (t<'a>, 'destination) => unit = "disconnect"
@send external triggerAttack: (t<'a>, string) => unit = "triggerAttack"
@send external triggerRelease: t<'a> => unit = "triggerRelease"

let initSynth = start()->Promise.thenResolve(_ => ())
let startSynth = synth => synth->connect(getDestination())
let stopSynth = synth => synth->disconnect(getDestination())

let triggerNote = (synth, note) => synth->triggerAttack(note)
let releaseNote = synth => triggerRelease(synth)
