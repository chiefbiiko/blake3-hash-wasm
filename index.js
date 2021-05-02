import React from "react"
import blake3, { init } from "./wasm/index.js"

init()

blake3.hash256 = function hash256(msg) {
  const out = new Uint8Array(32)

  blake3.hash(msg, out)

  return out.reduce((hex, byte) => `${hex}${byte < 16 ? "0" : ""}${byte.toString(16)}`, "")
}

const Blake3Context = React.createContext({ blake3 })

export function useBlake3() {
  return React.useContext(Blake3Context)
}

export default function Blake3Provider() {
  return <Blake3Context.Provider>{this.props.children}</Blake3Context.Provider>
}
