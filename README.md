# blake3-wasm-sync

[![ci](https://github.com/nuggetdigital/blake3-wasm-sync/workflows/ci/badge.svg)](https://github.com/nuggetdigital/blake3-wasm-sync/actions/workflows/ci.yml)

[BLAKE3](https://github.com/BLAKE3-team/BLAKE3)'s original wasm impl patchworkd as a *sync* loaded (4 ease of use) npm 📦

Due to this browser error, the `-sync` part actually just works in `node.js`:

```
Uncaught RangeError: WebAssembly.Compile is disallowed on the main thread, if the buffer size is larger than 4KB. Use WebAssembly.compile, or compile on a worker thread.
```

In the **browser** you need to `await` the `export`ed `async function init()` before using any other module exports.

`blake3-wasm-sync` adds a `hash256hex` convenience func ontop of the original API

## API

``` ts
export async function init(): Promise<void>;

export function hash256hex(data: Uint8Array): string;

export function hash(data: Uint8Array, out: Uint8Array): void;

export function create_hasher(): Blake3Hash;

export function create_keyed(key_slice: Uint8Array): Blake3Hash;

export function create_derive(context: string): Blake3Hash;

export class Blake3Hash {
  free(): void;
  reader(): HashReader;
  update(input_bytes: Uint8Array): void;
  digest(out: Uint8Array): void;
}

export class HashReader {
  free(): void;
  fill(bytes: Uint8Array): void;
  set_position(position: BigInt): void;
}  
```

## License

[MIT](./LICENSE)