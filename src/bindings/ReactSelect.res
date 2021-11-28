type value<'t> = 't

type option<'t> = {
  value: value<'t>,
  label: string,
}

type options<'a> = array<option<'a>>

@module("react-select") @react.component
external make: (
  ~options: 'a,
  ~onChange: value<'t> => unit,
  ~placeholder: string=?,
) => React.element = "default"
