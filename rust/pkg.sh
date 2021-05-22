#!/usr/bin/bash

wd="${1:-$(pwd)}"

npx wasm-pack build $wd --release

cp $wd/pkg/blake3_hash_wasm_bg.wasm.d.ts $wd/../index.wasm.d.ts

cp $wd/pkg/blake3_hash_wasm_bg.wasm $wd/../index.wasm

wasm_blob=$(base64 $wd/../index.wasm | tr -d ' \r\n\t')

echo -e "const WASM_BASE64 = '$wasm_blob'

function toBuf(base64) {
  if (typeof atob === 'function') {
    return Uint8Array.from(atob(base64), c => c.charCodeAt(0))
  } else {
    return Buffer.from(base64, 'base64')
  }
}

let wasm

export async function init() {
  if (!wasm && typeof document === 'object') {
    const res = await instantiateStreaming(
      fetch(
        URL.createObjectURL(new Blob([toBuf(WASM_BASE64)], { type: 'application/wasm' }))
      ),
      {}
    )
    wasm = res.instance.exports
  }
}

if (!wasm && typeof document === 'undefined') {
  wasm = new WebAssembly.Instance(new WebAssembly.Module(toBuf(WASM_BASE64)), {
    wbg: {
      __wbindgen_throw(arg0, arg1) {
        throw new Error(getStringFromWasm0(arg0, arg1))
      }
    }
  }).exports
}

let cachegetUint8Memory0 = null
function getUint8Memory0() {
  if (
    cachegetUint8Memory0 === null ||
    cachegetUint8Memory0.buffer !== wasm.memory.buffer
  ) {
    cachegetUint8Memory0 = new Uint8Array(wasm.memory.buffer)
  }
  return cachegetUint8Memory0
}

let WASM_VECTOR_LEN = 0

function passArray8ToWasm0(arg, malloc) {
  const ptr = malloc(arg.length * 1)
  getUint8Memory0().set(arg, ptr / 1)
  WASM_VECTOR_LEN = arg.length
  return ptr
}

export function hash(msg, out) {
  try {
    var ptr0 = passArray8ToWasm0(msg, wasm.__wbindgen_malloc)
    var len0 = WASM_VECTOR_LEN
    var ptr1 = passArray8ToWasm0(out, wasm.__wbindgen_malloc)
    var len1 = WASM_VECTOR_LEN
    wasm.hash(ptr0, len0, ptr1, len1)
  } finally {
    out.set(getUint8Memory0().subarray(ptr1 / 1, ptr1 / 1 + len1))
    wasm.__wbindgen_free(ptr1, len1 * 1)
  }
}

export function hash256hex(msg) {
  const out = new Uint8Array(32)
  hash(msg, out)
  return out.reduce(
    (hex, byte) => hex + (byte < 16 ? '0' : '') + byte.toString(16),
    ''
  )
}" \
> $wd/../index.js

echo -e "/* tslint:disable */
/* eslint-disable */

export async function init(): Promise<void>;
export function hash256hex(msg: Uint8Array): string;
export function hash(msg: Uint8Array, out: Uint8Array): void;" \
> $wd/../index.d.ts

echo -e "# blake3-hash-wasm

[![ci](https://github.com/nuggetdigital/blake3-hash-wasm/workflows/ci/badge.svg)](https://github.com/nuggetdigital/blake3-hash-wasm/actions/workflows/ci.yml)

[BLAKE3](https://github.com/BLAKE3-team/BLAKE3)'s \`hash\` func patchworkd as a mini *sync* loaded wasm npm 📦

## API

In the browser you need to \`await init()\` before using any other module exports.

\`\`\` ts
export async function init(): Promise<void>;
export function hash256hex(msg: Uint8Array): string;
export function hash(msg: Uint8Array, out: Uint8Array): void;
\`\`\`

## License

[MIT](./LICENSE)" \
> $wd/../README.md

rm -rf $wd/pkg/