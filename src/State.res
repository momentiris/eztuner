type userState = HasNotInteraced | HasInteracted
type synthState = IsPlaying | IsNotPlaying

type t = {
  userState: userState,
  synthState: synthState,
}

let initialState = {userState: HasNotInteraced, synthState: IsNotPlaying}

module Button = {
  module Note = {
    type t = Active | Inactive
  }
}
