import React from "react"
import { renderHook } from "@testing-library/react-hooks"
import { useBlake3, Blake3Provider } from "./index.js"
import { render, screen } from "@testing-library/react";

const BLAKE3256_EMPTY = Uint8Array.from([
  175,
  19,
  73,
  185,
  245,
  249,
  161,
  166,
  160,
  64,
  77,
  234,
  54,
  220,
  201,
  73,
  155,
  203,
  37,
  201,
  173,
  193,
  18,
  183,
  204,
  154,
  147,
  202,
  228,
  31,
  50,
  98
])

describe("useBlake3", () => {
  test("should supply a blake3 instance", () => {
    const {
      result: {
        current: { blake3 }
      }
    } = renderHook(() => useBlake3())
  
    expect(blake3).toBeTruthy()
    expect(typeof blake3.hash).toBe("function")
  })
  
  test("should hash correctly", () => {
    const {
      result: {
        current: { blake3 }
      }
    } = renderHook(() => useBlake3())
  
    const msg = new Uint8Array(0)
    const out = new Uint8Array(32)
  
    blake3.hash(msg, out)
  
    expect(out).toEqual(BLAKE3256_EMPTY)
  })
})

describe("Blake3Provider", () => {

  class Blake3Consumer extends React.Component {  
     render() {
       return (
         <div>BLAKE3256 EMPTY HASH{this.props.blake3.hash256(new Uint8Array(0))}</div>
       )
     }
  }

    it("passes a handy blake3 instance to its consumers", () => {
      render(  <Blake3Provider>  <Blake3Consumer />  </Blake3Provider> );

      // TODO
      // expect(theme.onThemeChange).toHaveBeenCalledWith("light");
    });

})
