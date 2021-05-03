# blake3-wasm-sync

[![ci](https://github.com/nuggetdigital/blake3-wasm-sync/workflows/ci/badge.svg)](https://github.com/nuggetdigital/blake3-wasm-sync/actions/workflows/ci.yml)

[BLAKE3](https://github.com/BLAKE3-team/BLAKE3)'s original wasm impl patchworkd as a *sync* loaded (4 ease of use) npm 📦

Additionally, `blake3-wasm-sync` adds a `hash256hex` convenience func

## API

``` ts
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