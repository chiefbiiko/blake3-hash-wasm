import React from "react"
import blake3, { init } from "./wasm/index.js"

init()

const Blake3Context = React.createContext({ blake3 })

export function useBlake3() {
  return React.useContext(Blake3Context)
}

export default function Blake3Provider() {
  return <Blake3Context.Provider>{this.props.children}</Blake3Context.Provider>
}
