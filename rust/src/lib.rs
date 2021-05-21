use blake3::Hasher;
use wasm_bindgen::prelude::wasm_bindgen;

#[wasm_bindgen]
pub fn hash(data: &[u8], out: &mut [u8]) {
    let mut hasher = Hasher::new();
    hasher.update(data);
    let mut reader = hasher.finalize_xof();
    reader.fill(out);
}