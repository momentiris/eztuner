// Generated by ReScript, PLEASE EDIT WITH CARE
'use strict';

var Note = require("./components/Note.bs.js");
var Curry = require("rescript/lib/js/curry.js");
var Icons = require("./bindings/Icons.bs.js");
var React = require("react");
var Button = require("./components/Button.bs.js");
var Constants = require("./Constants.bs.js");
var Belt_Array = require("rescript/lib/js/belt_Array.js");
var Caml_array = require("rescript/lib/js/caml_array.js");
var Belt_Option = require("rescript/lib/js/belt_Option.js");
var Caml_option = require("rescript/lib/js/caml_option.js");

function Free$Placeholder(Props) {
  return React.createElement("div", {
              className: "flex flex-shrink-0 w-halfNote"
            });
}

var Placeholder = {
  make: Free$Placeholder
};

function Free(Props) {
  var userState = Props.userState;
  var onUserInteraction = Props.onUserInteraction;
  var onMute = Props.onMute;
  var onUnmute = Props.onUnmute;
  var isPlaying = Props.isPlaying;
  var triggerAttack = Props.triggerAttack;
  var match = React.useState(function () {
        return "C2";
      });
  var setActiveNote = match[1];
  var activeNote = match[0];
  var containerRef = React.useRef(null);
  var noteRefs = Belt_Array.map(Constants.baseNotes, (function (param) {
          return React.createRef();
        }));
  React.useEffect((function () {
          if (userState) {
            return Belt_Option.flatMap(Caml_option.nullable_to_opt(containerRef.current), (function (node) {
                          var partial_arg = 0.5;
                          var partial_arg$1 = Caml_option.some(node);
                          var options = function (param) {
                            var tmp = {};
                            if (partial_arg$1 !== undefined) {
                              tmp.root = Caml_option.valFromOption(partial_arg$1);
                            }
                            if (partial_arg !== undefined) {
                              tmp.threshold = Caml_option.valFromOption(partial_arg);
                            }
                            return tmp;
                          };
                          var observer = new IntersectionObserver((function (entries) {
                                  Belt_Option.map(Belt_Option.map(Belt_Array.getBy(entries, (function (prim) {
                                                  return prim.isIntersecting;
                                                })), (function (prim) {
                                              return prim.target;
                                            })), (function (el) {
                                          Curry._1(setActiveNote, (function (param) {
                                                  return el.id;
                                                }));
                                          return Curry._1(triggerAttack, el.id);
                                        }));
                                  
                                }), Curry._1(options, undefined));
                          Belt_Array.forEach(Belt_Array.keepMap(noteRefs, (function (ref) {
                                      return Caml_option.nullable_to_opt(ref.current);
                                    })), (function (param) {
                                  observer.observe(param);
                                  
                                }));
                          return (function (param) {
                                    observer.disconnect();
                                    
                                  });
                        }));
          }
          
        }), [userState]);
  return React.createElement("div", {
              className: "w-full flex flex-col justify-center items-center flex-grow"
            }, React.createElement("div", {
                  className: "w-8 mb-2 text-light"
                }, React.createElement(Icons.Arrow.make, {})), React.createElement("div", {
                  ref: containerRef,
                  className: "flex justify-center overflow-x-visible w-note"
                }, React.createElement("div", {
                      className: "snappable overflow-x-auto flex flex-shrink-0 w-screen text-xl pb-4 mb-12"
                    }, React.createElement(Free$Placeholder, {}), Belt_Array.mapWithIndex(Constants.baseNotes, (function (i, note) {
                            return React.createElement(Note.make, {
                                        active: note === activeNote,
                                        note: note,
                                        nodeRef: Caml_array.get(noteRefs, i),
                                        key: note
                                      });
                          })), React.createElement(Free$Placeholder, {}))), React.createElement("div", {
                  className: "max-w-xs"
                }, React.createElement(Button.Unmute.make, {
                      children: isPlaying ? "Pause" : "Play",
                      onClick: (function (param) {
                          if (isPlaying) {
                            Curry._1(onMute, undefined);
                          } else {
                            Curry._1(onUnmute, undefined);
                          }
                          
                        }),
                      onMouseDown: (function (param) {
                          return Curry._1(onUserInteraction, undefined);
                        })
                    })));
}

var make = Free;

exports.Placeholder = Placeholder;
exports.make = make;
/* Note Not a pure module */
