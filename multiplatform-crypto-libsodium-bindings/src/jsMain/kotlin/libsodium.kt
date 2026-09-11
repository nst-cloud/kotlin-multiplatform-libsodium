package ext.libsodium

import org.khronos.webgl.Uint8Array
import kotlin.js.Promise


/**
 * Created by Ugljesa Jovanovic
 * ugljesa.jovanovic@ionspin.com
 * on 25-May-2020
 */

// libsodium-sumo's ESM build (dist/modules-sumo-esm/libsodium-sumo.mjs) has exactly one export,
// `export default`, no named exports. `external object` + `@JsModule` compiles to a namespace
// import (`import * as LibsodiumSumo from 'libsodium-sumo'`), which against a default-export-only
// ESM module yields only `{ default: ... }` - every member below reads back `undefined`. A plain
// `external val` with `@JsModule` compiles to a default import instead (`import LibsodiumSumo from
// 'libsodium-sumo'`), which is what actually lines up with this module's shape - and still compiles
// to `const LibsodiumSumo = require('libsodium-sumo')` for the CommonJS target, so this is not a
// behavior change there.
external interface LibsodiumSumoModule {

    @JsName("ready")
    val _libsodiumPromise : Promise<dynamic>

    @JsName("_sodium_init")
    fun sodium_init() : Int

    fun crypto_generichash(hashLength: Int, inputMessage: Uint8Array) : Uint8Array

    fun crypto_hash_sha256(message: Uint8Array) : Uint8Array
    fun crypto_hash_sha512(message: Uint8Array) : Uint8Array

    fun crypto_hash_sha256_init(): dynamic
}

@JsModule("libsodium-sumo")
@JsNonModule
external val LibsodiumSumo: LibsodiumSumoModule





