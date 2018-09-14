@echo Project generation started...
set CMAKE_BINARY_DIR=C:\bin\cmake-3.11.4-win64-x64\bin
@mkdir build
@pushd build
%CMAKE_BINARY_DIR%\cmake.exe --warn-uninitialized --warn-unused-vars -G"Visual Studio 12 2013" -DCMAKE_TOOLCHAIN_FILE=NsightTegraToolchain.cmake .. 2>&1
@popd
