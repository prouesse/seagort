# Seagort JS Engine
This is the Seagort JS Engine, the code used to produce the functions used in rendering JS on the dart VM.

This is the rust implementation of the JS Engine, using the Deno bindings for the V8 Engine.

## Building
In order to build this, you will need to have `cargo` and `rustup` installed. You will also need the `cbindgen` command to generate header files.
```bash
cargo install --force cbindgen
```

When you are done, run `cargo build --release` and `cbindgen --config cbindgen.toml --lang c --output libseagort.h` from the root of the directory.

If you want to install all targets (linux, windows, mac arm, mac intel), then you will need `cross` installed.

Once you have these, run the `build.sh` script to generate all target files.
```bash
./build.sh
./build.sh --release # Add this if you want release versions
```

## Contributing
Contributions are welcome as this is a work in progress

Read the [contributing guidelines]() to know how you can contribute.