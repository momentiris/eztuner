@react.component
let make = () => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let toggle = () => setIsOpen(isOpen => !isOpen)

  <div>
    <div
      className={`fixed text-black w-screen h-screen transform left-0 flex justify-center items-center text-2xl z-10 ${isOpen
          ? " translate-x-0 opacity-1 bg-white"
          : " translate-x-full opacity-0"}`}>
      <Menu onClick={toggle} />
    </div>
    <div className="bajs bottom-0 right-0 flex items-center justify-center z-20">
      <div
        onClick={_ => toggle()}
        className="fixed bottom-10 right-10 w-20 h-20 bg-gray-500 rounded-full flex items-center justify-center z-50">
        <Icons.Hamburger size="48" />
      </div>
    </div>
  </div>
}
