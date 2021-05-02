// Polyfill for encoding which isn't present globally in jsdom
const { TextEncoder, TextDecoder } = require("util")
global.TextEncoder = TextEncoder
global.TextDecoder = TextDecoder
