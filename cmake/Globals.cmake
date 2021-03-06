# The Lib Prefix
if (UNIX)
  set(LIB_PFX "lib")
  if (APPLE)
    set(LIB_EXT ".dylib")
  else ()
    set(LIB_EXT ".so")
  endif ()
else (UNIX)
  set(LIB_PFX "")
  set(LIB_EXT ".dll")
endif (UNIX)

message(STATUS "")
message(STATUS "********* Detect-Build-Info ***********")


# The Processor
set(PROCESSOR.Detected 1)
if(CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
  set(PROCESSOR.X86_64 1)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "i686.*|i386.*|x86.*|amd64.*|AMD64.*")
  set(PROCESSOR.X86 1)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(arm.*|ARM.*)")
  set(PROCESSOR.ARM 1)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64.*|AARCH64.*)")
  set(PROCESSOR.AARCH64 1)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(powerpc|ppc)64le")
  message(STATUS "NOT SUPPORT ${CMAKE_SYSTEM_PROCESSOR}")
  set(PROCESSOR.PPC64LE 1)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(powerpc|ppc)64")
  message(STATUS "NOT SUPPORT ${CMAKE_SYSTEM_PROCESSOR}")
  set(PROCESSOR.PPC64 1)
else()
  set(PROCESSOR.Detected 0)
endif()
message(STATUS "\tPROCESSOR:\t ${CMAKE_SYSTEM_PROCESSOR}")

# The System
set(SYSTEM.Detected 1)
if(CMAKE_SYSTEM_NAME MATCHES "^Android")
  set(SYSTEM.Android 1)
  set(SYSTEM.Posix 1)
elseif(CMAKE_SYSTEM_NAME MATCHES "^Windows")
  set(SYSTEM.Windows 1)
elseif(CMAKE_SYSTEM_NAME MATCHES "^Linux")
  set(SYSTEM.Linux 1)
  set(SYSTEM.Posix 1)
elseif(CMAKE_SYSTEM_NAME MATCHES "^iOS")
  set(SYSTEM.iOS 1)
  set(SYSTEM.Darwin 1)
  set(SYSTEM.Posix 1)
elseif(CMAKE_SYSTEM_NAME MATCHES "^Darwin")
  if(PROCESSOR.AARCH64 OR PROCESSOR.ARM)
    set(CMAKE_SYSTEM_NAME "iOS")
    set(SYSTEM.iOS 1)
  elseif(PROCESSOR.X86 OR PROCESSOR.X86_64)
    set(CMAKE_SYSTEM_NAME "macOS")
    set(SYSTEM.macOS 1)
  endif()
  set(SYSTEM.Darwin 1)
  set(SYSTEM.Posix 1)
else()
  set(SYSTEM.Detected 0)
endif()
message(STATUS "\tSystem:\t\t ${CMAKE_SYSTEM_NAME}")

# The Compilter ID
set(COMPILER.Detected 1)
if ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Clang" OR "${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
  set(COMPILER.Clang 1)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
  set(COMPILER.Gcc 1)
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "Intel")
elseif ("${CMAKE_CXX_COMPILER_ID}" STREQUAL "MSVC")
  set(COMPILER.MSVC 1)
else()
  set(COMPILER.Detected 0)
endif()
message(STATUS "\tCompiler:\t ${CMAKE_CXX_COMPILER_ID}")

message(STATUS "***************************************")
message(STATUS "")
