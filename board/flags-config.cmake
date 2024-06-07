# This function provides a set of specific flags for each supported board
# depending on the processor type. The objective is to optimize for size.
# Thus, all of the following flags are chosen carefully to reduce binary 
# footprints.

# Set generic minimization flags for all platforms.
# These flags are the same for all cross-compilation cases and they are
# mainly to reduce the binary footprint.
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Os -s -fdata-sections -ffunction-sections")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fomit-frame-pointer -fno-unwind-tables")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-asynchronous-unwind-tables -fvisibility=hidden")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fshort-enums -finline-small-functions")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -findirect-inlining -fno-common")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fmerge-all-constants -fno-ident")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-unroll-loops -fno-math-errno")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fno-stack-protector -Wl,-z,norelro")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -flto -Wl,--hash-style=gnu -Wl,--build-id=none")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -nostartfiles") ## this get us 400KB alone
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -Wl,-nmagic,-Bsymbolic")


set(BOARD_NAME "" CACHE STRING "Specify Board name to optimize for.")
string(TOUPPER ${BOARD_NAME} BOARD)

# Set specific platforms CMAKE CXX flags.
if(BOARD MATCHES "RPI0" OR BOARD MATCHES "RPI1" OR BOARD MATCHES "ARM11")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=arm1176jzf-s")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcpu=arm1176jzf-s -mfloat-abi=hard -mfpu=vfp")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "ARMV6")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "RPI2" OR BOARD MATCHES "CORTEXA7")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a7")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfloat-abi=hard -mfpu=neon-vfpv4")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "ARMV7")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "CORTEXA8")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a8")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfloat-abi=hard -mfpu=neon")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "ARMV7")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "CORTEXA9")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a9")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfloat-abi=hard -mfpu=neon")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "CORTEXA9")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "CORTEXA15")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a15")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfloat-abi=hard -mfpu=neon")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "CORTEXA15")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "RPI3" OR BOARD MATCHES "CORTEXA53")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a53 -mfloat-abi=hard")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon-fp-armv8 -mneon-for-64bit")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "CORTEXA53")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "RPI4" OR BOARD MATCHES "CORTEXA72")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a72 -mfloat-abi=hard")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon-fp-armv8 -mneon-for-64bit")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "CORTEXA72")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "JETSONAGX" OR BOARD MATCHES "CORTEXA76")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=cortex-a76 -mfloat-abi=hard")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mfpu=neon-fp-armv8 -mneon-for-64bit")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "CORTEXA76")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "BV")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "RISCV64_GENERIC")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "C906")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=thead-c906")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "RISCV64_GENERIC")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "x280")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mtune=sifive-x280")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "x280")
  set(OPENBLAS_BINARY "64")
elseif(BOARD MATCHES "KATAMI")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=pentium3")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "KATAMI")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "COPPERMINE")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=pentium3")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "COPPERMINE")
  set(OPENBLAS_BINARY "32")
elseif(BOARD MATCHES "NORTHWOOD")
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=pentium4")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--gc-sections")
  set(OPENBLAS_TARGET "NORTHWOOD")
  set(OPENBLAS_BINARY "32")
elseif(BOARD)
  ## TODO: update documentation with a list of the supported boards.
  message(FATAL_ERROR "Given BOARD_NAME is not known; please choose a supported board from the list")
endif()
