import tape from "tape"
import { hash256hex } from "./index.js"
import { createRequire } from "module"

function toTestMsg(input_len) {
  const msg = new Uint8Array(input_len)
  for (let i = 0, j = 0; i < msg.length; ++i, ++j) {
    if (j > 250) j = 0
    msg[i] = j
  }
  return msg
}

const testVectors = createRequire(import.meta.url)("./test_vectors.json")

console.log(testVectors._comment)

console.log("\nNOTE: this test suite only tests the added hash256hex func\n")

testVectors.cases.forEach(({ input_len, hash: expected }, i) => {
  tape(`blake3-wasm-sync hash256hex [${i}]`, t => {
    const msg = toTestMsg(input_len)

    const hash = hash256hex(msg)

    t.equal(hash, expected.slice(0, 64))

    t.end()
  })
})
