> [!CAUTION]
> Experimental library!

# Libsodium bindings for Kotlin Multiplatform

Libsodium bindings project uses libsodium c sources and libsodium.js to provide a kotlin multiplatform wrapper library for libsodium. The library is feature complete and usable.

## Fork notice

This is a fork of [ionspin/kotlin-multiplatform-libsodium](https://github.com/ionspin/kotlin-multiplatform-libsodium) by [Ugljesa Jovanovic](https://github.com/ionspin), created to add ESM support for Kotlin/JS.

## Installation

#### Snapshot builds
```kotlin
repositories {
    maven("https://central.sonatype.com/repository/maven-snapshots/")
}

dependencies {
    implementation("cloud.nst:multiplatform-crypto-libsodium-bindings:0.9.6-SNAPSHOT")
}
```
