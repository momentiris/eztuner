type userState = HasNotInteraced | HasInteracted

type t = {
  userState: userState,
  isPlaying: bool,
}

let initialState = {userState: HasNotInteraced, isPlaying: false}
