## What exactly are these tools for?
Well. There are a couple of different files in the directory and I'll just go ahead and step through each one below in the order that they are used.

* `env_init.bat` should not be changed at all. The only exception being the `TOOLCHAIN_SETUP_PATH` environment variable. This script is responsible for setting up basic utility vars for use within the other scripts and **should not** be ran by itself.
* `dump_dll.bat` performs a `dumpbin` on the `.dll` file that gets passed to it as an argument.
* `build_exports.bat` takes the dumped file created from the previous script (passed as an argument) and trims the fat to create an exports file.
* `build_libs.bat` takes the exports file created from the previous script (passed as an argument) and creates `x86` and `x64` **static** library versions.
