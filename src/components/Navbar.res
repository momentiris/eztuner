@react.component
let make = () => {
  let (isOpen, setIsOpen) = React.useState(_ => false)
  let toggle = () => setIsOpen(isOpen => !isOpen)

  <div>
    <div
      className={`fixed transition-opacity duration-150 text-black w-screen h-screen transform left-0 flex justify-center items-center text-2xl z-10 ${isOpen
          ? "translate-x-0 opacity-100 bg-light"
          : "translate-x-full opacity-0 bg-light"}`}>
      <Menu onClick={toggle} />
    </div>
    <div className="bottom-0 right-0 flex items-center justify-center z-20">
      <div
        onClick={_ => toggle()}
        className={`fixed bottom-5 right-5 w-14 h-14 bg-gray-500 rounded-full flex items-center justify-center z-50 ${isOpen
            ? "text-dark transition-colors duration-150"
            : "text-accentlight "}`}>
        <Icons.Hamburger size="32" />
      </div>
    </div>
  </div>
}
