type t = Dom.intersectionObserver

module Entry = {
  type t = Dom.intersectionObserverEntry
  type el = {id: string}
  @get external isIntersecting: t => bool = "isIntersecting"
  @get external target: t => el = "target"
}

@deriving(abstract)
type options = {
  @optional
  root: Dom.element,
  @optional
  threshold: float,
}

@new
external make: (array<Entry.t> => unit, options) => t = "IntersectionObserver"

@send external observe: (t, Dom.element) => unit = "observe"
@send external disconnect: t => unit = "disconnect"
