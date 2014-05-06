include(Compiler/Clang)
__compiler_clang(CXX)

if(NOT CMAKE_CXX_SIMULATE_ID STREQUAL "MSVC")
  set(CMAKE_CXX_COMPILE_OPTIONS_VISIBILITY_INLINES_HIDDEN "-fvisibility-inlines-hidden")
endif()

cmake_policy(GET CMP0025 appleClangPolicy)
if(NOT appleClangPolicy STREQUAL NEW)
  return()
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 2.1)
  set(CMAKE_CXX98_STANDARD_COMPILE_OPTION "-std=c++98")
  set(CMAKE_CXX98_EXTENSION_COMPILE_OPTION "-std=gnu++98")
endif()

if(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.1)
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++11")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++11")
elseif(NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 2.1)
  set(CMAKE_CXX11_STANDARD_COMPILE_OPTION "-std=c++0x")
  set(CMAKE_CXX11_EXTENSION_COMPILE_OPTION "-std=gnu++0x")
endif()

macro(cmake_record_cxx_compile_features)
  macro(_get_clang_features std_version list)
    record_compiler_features(CXX "-std=${std_version}" ${list})
  endmacro()

  if (UNIX AND NOT APPLE AND NOT CMAKE_SYSTEM_NAME STREQUAL FreeBSD
      AND NOT CMAKE_CXX_COMPILER_VERSION VERSION_LESS 3.4)
    _get_clang_features(c++11 CMAKE_CXX11_COMPILE_FEATURES)
    if (_result EQUAL 0)
      _get_clang_features(c++98 CMAKE_CXX98_COMPILE_FEATURES)
    endif()
  else()
    set(_result 0)
  endif()
endmacro()
