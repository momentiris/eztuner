let baseNotes = [
  "A1",
  "A#1",
  "B1",
  "C2",
  "C#2",
  "D2",
  "D#2",
  "E2",
  "F2",
  "F#2",
  "G2",
  "G#2",
  "A2",
  "A#2",
  "B2",
  "C3",
  "C#3",
  "D3",
  "D#3",
  "E3",
  "F3",
  "F#3",
  "G3",
  "G#3",
  "A3",
  "A#3",
  "B3",
  "C4",
  "C#4",
  "D4",
  "D#4",
  "E4",
  "F4",
  "F#4",
  "G4",
  "G#4",
  "A4",
  "A#4",
  "B4",
  "C5",
]

module Tuning = {
  type t = {label: string, value: array<(string, string)>}

  let standard = {
    label: "Standard",
    value: [("E2", "E2"), ("A2", "A2"), ("D3", "D3"), ("G3", "G3"), ("B3", "B3"), ("E4", "E4")],
  }

  let halfStepDown = {
    label: "Half step down",
    value: [
      ("E2", "D#2"),
      ("A2", "G#2"),
      ("D3", "C#3"),
      ("G3", "F#3"),
      ("B3", "A#3"),
      ("E4", "D#4"),
    ],
  }

  let fullstepDown = {
    label: "Full step down",
    value: [("E2", "D2"), ("A2", "G2"), ("D3", "C3"), ("G3", "F3"), ("B3", "A3"), ("E4", "D4")],
  }

  let dropD = {
    label: "Drop D",
    value: [("E2", "D2"), ("A2", "A2"), ("D3", "D3"), ("G3", "G3"), ("B3", "B3"), ("E4", "E4")],
  }

  let doubleDropD = {
    label: "Double drop D",
    value: [("E2", "D2"), ("A2", "A2"), ("D3", "D3"), ("G3", "G3"), ("B3", "B3"), ("E4", "D4")],
  }

  let dMinor = {
    label: "D minor",
    value: [("E2", "D2"), ("A2", "A2"), ("D3", "D3"), ("G3", "F3"), ("B3", "A3"), ("E4", "D4")],
  }

  let openG = {
    label: "Open G",
    value: [("E2", "D2"), ("A2", "G2"), ("D3", "D3"), ("G3", "G3"), ("B3", "B3"), ("E4", "D4")],
  }

  let openD = {
    label: "Open D",
    value: [("E2", "D2"), ("A2", "A2"), ("D3", "D3"), ("G3", "F#3"), ("B3", "A3"), ("E4", "D4")],
  }

  let openC = {
    label: "Open C",
    value: [("E2", "C2"), ("A2", "G2"), ("D3", "C3"), ("G3", "G3"), ("B3", "C4"), ("E4", "E4")],
  }

  let tunings = [standard, fullstepDown, dropD, doubleDropD, dMinor, openG, openD, openC]
}
