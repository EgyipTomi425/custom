# Custom modules

`CMakeLists.txt`, `config.cmake` and `custom.cppm` are the tracked default
configuration. The corresponding `Template*` files show how to add independent
modules with inline initialization. No bot-core changes are required.

The private `gge_sdk` is optional and uses `update = none` in `.gitmodules`.
Public recursive clones skip it, and CMake skips it when either the SDK or its
pinned WebSocket submodule is absent. No credentials or downloads are requested
by CMake. Use `-DGGE_SDK=OFF` to disable an available SDK.

Authorized developers can initialize it explicitly:

```sh
git submodule update --init --checkout gge_sdk
git -C gge_sdk submodule update --init --recursive
```

The SDK contains its own `Echter_Websockets` submodule and requires the system
packages documented in its private README. Tools and tests default to OFF when
embedded. The custom module exposes SDK APIs without registering any Discord
commands or creating SDK client sessions.
