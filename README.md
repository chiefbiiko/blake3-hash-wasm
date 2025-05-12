# blake3-hash-wasm

[![ci](https://github.com/nuggetdigital/blake3-hash-wasm/workflows/ci/badge.svg)](https://github.com/nuggetdigital/blake3-hash-wasm/actions/workflows/ci.yml)

[BLAKE3](https://github.com/BLAKE3-team/BLAKE3)'s `hash` func patchworkd as a mini wasm npm 📦

## API

``` ts
export function hash256hex(msg: Uint8Array): string;
export function hash(msg: Uint8Array, out: Uint8Array): void;
```

## License

[MIT](./LICENSE)
