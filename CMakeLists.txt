cmake_minimum_required(VERSION 3.6)

set(CMAKE_BUILD_TYPE MINSIZEREL)
set(PROJ_DIR ${CMAKE_CURRENT_LIST_DIR})
set(BUILD_DIR ${CMAKE_CURRENT_BINARY_DIR})
set(CMAKE_INSTALL_PREFIX ${PROJ_DIR}/release CACHE STRING "")
set(CMAKE_TOOLCHAIN_FILE ${PROJ_DIR}/toolchain.cmake)

project(kokiri VERSION 0.0 LANGUAGES C CXX ASM)

if("${CMAKE_SOURCE_DIR}" STREQUAL "${CMAKE_BINARY_DIR}")
	message(FATAL_ERROR "In-source build is not allowed, please use a separate build folder.")
endif()

# Build Arm CMSIS DSP library
set(ROOT ${PROJ_DIR}					CACHE STRING "")

# We fake this function, because we already do the work it
#  claims to do, and we don't want it overwriting that
function(compilerSpecificCompileOptions PROJECTNAME)
endfunction()

add_subdirectory(${ROOT}/CMSIS/DSP/Source ${BUILD_DIR}/CMSIS/DSP)


# LLVM Compiler Runtime
set(COMPILER_RT_OS_DIR					"compiler-rt"	CACHE STRING "")
set(COMPILER_RT_BUILD_BUILTINS			ON				CACHE BOOL "")
set(COMPILER_RT_BUILD_SANITIZERS		OFF				CACHE BOOL "")
set(COMPILER_RT_BUILD_XRAY				OFF				CACHE BOOL "")
set(COMPILER_RT_BUILD_LIBFUZZER			OFF				CACHE BOOL "")
set(COMPILER_RT_BUILD_PROFILE			OFF				CACHE BOOL "")
set(COMPILER_RT_BAREMETAL_BUILD			ON				CACHE BOOL "")
set(COMPILER_RT_DEFAULT_TARGET_ONLY		ON				CACHE BOOL "")
set(COMPILER_RT_INCLUDE_TESTS			OFF				CACHE BOOL "")

add_subdirectory(${PROJ_DIR}/compiler-rt)


# MUSL libc
# include(ExternalProject)

# set(MUSL_CFLAGS "${CMAKE_C_FLAGS} ${CMAKE_C_FLAGS_${CMAKE_BUILD_TYPE}} -target ${CMAKE_ASM_COMPILER_TARGET}")
# set(MUSL_LDFLAGS "${CMAKE_EXE_LINKER_FLAGS} ${CMAKE_EXE_LINKER_FLAGS_${CMAKE_BUILD_TYPE}}")

# set(musl_configure
# 	<SOURCE_DIR>/configure
# 		--srcdir=<SOURCE_DIR>
# 		--target=${CMAKE_ASM_COMPILER_TARGET}
# 		--disable-shared
# 		--prefix=${CMAKE_INSTALL_PREFIX}/musl
# 		--syslibdir=${CMAKE_INSTALL_PREFIX}/musl/lib
# 		LIBCC=-lcompiler-rt
# 		CC=${CMAKE_C_COMPILER}
# 		AR=${CMAKE_AR}
# 		RANLIB=${CMAKE_RANLIB}
# 		CFLAGS=${MUSL_CFLAGS}
# 		LDFLAGS=${MUSL_LDFLAGS}
# )

# ExternalProject_Add(musl
# 	GIT_REPOSITORY				git://git.musl-libc.org/musl
# 	GIT_TAG						v1.2.2
# 	GIT_SHALLOW					1
# 	GIT_PROGRESS				1
# 	BINARY_DIR					${CMAKE_CURRENT_BINARY_DIR}/musl
# 	CONFIGURE_COMMAND 			${musl_configure}
# 	USES_TERMINAL				1
# 	USES_TERMINAL_DOWNLOAD		1
# 	USES_TERMINAL_UPDATE		1
# 	USES_TERMINAL_CONFIGURE		1
# 	USES_TERMINAL_BUILD			1
# 	USES_TERMINAL_INSTALL		1
# 	BUILD_ALWAYS				0
# 	BUILD_BYPRODUCTS			<BINARY_DIR>/lib/libc.a
# )

set(MUSL_LGCC 							"-lcompiler-rt" CACHE STRING "")
add_subdirectory(${PROJ_DIR}/musl)
