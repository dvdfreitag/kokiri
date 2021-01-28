cmake_minimum_required (VERSION 3.6)

project(CMSISDSP)

# DSP Sources
set(PROJ_DIR ${CMAKE_CURRENT_LIST_DIR})
set(SRC_DIR ${PROJ_DIR}/DSP/Source)

option(NEON "Neon acceleration" OFF)
option(NEONEXPERIMENTAL "Neon experimental acceleration" OFF)
option(LOOPUNROLL "Loop unrolling" ON)
option(ROUNDING "Rounding" OFF)
option(MATRIXCHECK "Matrix Checks" OFF)
option(HELIUM "Helium acceleration (MVEF and MVEI supported)" OFF)
option(MVEF "MVEF intrinsics supported" OFF)
option(MVEI "MVEI intrinsics supported" OFF)

# Select which parts of the CMSIS-DSP must be compiled.
# There are some dependencies between the parts but they are not tracked
# by this cmake. So, enabling some functions may require to enable some
# other ones.
option(BASICMATH            "Basic Math Functions"              ON)
option(COMPLEXMATH          "Complex Math Functions"            ON)
option(CONTROLLER           "Controller Functions"              ON)
option(FASTMATH             "Fast Math Functions"               ON)
option(FILTERING            "Filtering Functions"               ON)
option(MATRIX               "Matrix Functions"                  ON)
option(STATISTICS           "Statistics Functions"              ON)
option(SUPPORT              "Support Functions"                 ON)
option(TRANSFORM            "Transform Functions"               ON)
option(SVM                  "Support Vector Machine Functions"  ON)
option(BAYES                "Bayesian Estimators"               ON)
option(DISTANCE             "Distance Functions"                ON)

# When OFF it is the default behavior : all tables are included.
option(CONFIGTABLE          "Configuration of table allowed"    OFF)

# When CONFIGTABLE is ON, select if all interpolation tables must be included
option(ALLFAST              "All interpolation tables included" OFF)
# When CONFIGTABLE is ON, select if all FFT tables must be included
option(ALLFFT               "All fft tables included"           OFF)

# Features which require inclusion of a data table.
# Since some tables may be big, the corresponding feature can be
# disabled.
# Those options are taken into account only when CONFIGTABLE is ON
option(ARM_COS_F32          "cos f32"                           OFF)
option(ARM_COS_Q31          "cos q31"                           OFF)
option(ARM_COS_Q15          "cos q15"                           OFF)
option(ARM_SIN_F32          "sin f32"                           OFF)
option(ARM_SIN_Q31          "sin q31"                           OFF)
option(ARM_SIN_Q15          "sin q15"                           OFF)
option(ARM_SIN_COS_F32      "sin cos f32"                       OFF)
option(ARM_SIN_COS_Q31      "sin cos q31"                       OFF)

option(ARM_LMS_NORM_Q31     "lms norm q31"                      OFF)
option(ARM_LMS_NORM_Q15     "lms norm q15"                      OFF)

option(CFFT_F64_16          "cfft f64 16"                       OFF)
option(CFFT_F64_32          "cfft f64 32"                       OFF)
option(CFFT_F64_64          "cfft f64 64"                       OFF)
option(CFFT_F64_128         "cfft f64 128"                      OFF)
option(CFFT_F64_256         "cfft f64 256"                      OFF)
option(CFFT_F64_512         "cfft f64 512"                      OFF)
option(CFFT_F64_1024        "cfft f64 1024"                     OFF)
option(CFFT_F64_2048        "cfft f64 2048"                     OFF)
option(CFFT_F64_4096        "cfft f64 4096"                     OFF)

option(CFFT_F32_16          "cfft f32 16"                       OFF)
option(CFFT_F32_32          "cfft f32 32"                       OFF)
option(CFFT_F32_64          "cfft f32 64"                       OFF)
option(CFFT_F32_128         "cfft f32 128"                      OFF)
option(CFFT_F32_256         "cfft f32 256"                      OFF)
option(CFFT_F32_512         "cfft f32 512"                      OFF)
option(CFFT_F32_1024        "cfft f32 1024"                     OFF)
option(CFFT_F32_2048        "cfft f32 2048"                     OFF)
option(CFFT_F32_4096        "cfft f32 4096"                     OFF)

option(CFFT_Q31_16          "cfft q31 16"                       OFF)
option(CFFT_Q31_32          "cfft q31 32"                       OFF)
option(CFFT_Q31_64          "cfft q31 64"                       OFF)
option(CFFT_Q31_128         "cfft q31 128"                      OFF)
option(CFFT_Q31_256         "cfft q31 256"                      OFF)
option(CFFT_Q31_512         "cfft q31 512"                      OFF)
option(CFFT_Q31_1024        "cfft q31 1024"                     OFF)
option(CFFT_Q31_2048        "cfft q31 2048"                     OFF)
option(CFFT_Q31_4096        "cfft q31 4096"                     OFF)

option(CFFT_Q15_16          "cfft q15 16"                       OFF)
option(CFFT_Q15_32          "cfft q15 32"                       OFF)
option(CFFT_Q15_64          "cfft q15 64"                       OFF)
option(CFFT_Q15_128         "cfft q15 128"                      OFF)
option(CFFT_Q15_256         "cfft q15 256"                      OFF)
option(CFFT_Q15_512         "cfft q15 512"                      OFF)
option(CFFT_Q15_1024        "cfft q15 1024"                     OFF)
option(CFFT_Q15_2048        "cfft q15 2048"                     OFF)
option(CFFT_Q15_4096        "cfft q15 4096"                     OFF)

option(RFFT_FAST_F32_32     "rfft fast f32 32"                  OFF)
option(RFFT_FAST_F32_64     "rfft fast f32 64"                  OFF)
option(RFFT_FAST_F32_128    "rfft fast f32 128"                 OFF)
option(RFFT_FAST_F32_256    "rfft fast f32 256"                 OFF)
option(RFFT_FAST_F32_512    "rfft fast f32 512"                 OFF)
option(RFFT_FAST_F32_1024   "rfft fast f32 1024"                OFF)
option(RFFT_FAST_F32_2048   "rfft fast f32 2048"                OFF)
option(RFFT_FAST_F32_4096   "rfft fast f32 4096"                OFF)


option(RFFT_F32_128         "rfft f32 128"                      OFF)
option(RFFT_F32_512         "rfft f32 512"                      OFF)
option(RFFT_F32_2048        "rfft f32 2048"                     OFF)
option(RFFT_F32_8192        "rfft f32 8192"                     OFF)

option(RFFT_FAST_F64_32     "rfft fast f64 32"                  OFF)
option(RFFT_FAST_F64_64     "rfft fast f64 64"                  OFF)
option(RFFT_FAST_F64_128    "rfft fast f64 128"                 OFF)
option(RFFT_FAST_F64_256    "rfft fast f64 256"                 OFF)
option(RFFT_FAST_F64_512    "rfft fast f64 512"                 OFF)
option(RFFT_FAST_F64_1024   "rfft fast f64 1024"                OFF)
option(RFFT_FAST_F64_2048   "rfft fast f64 2048"                OFF)
option(RFFT_FAST_F64_4096   "rfft fast f64 4096"                OFF)


option(RFFT_F64_128         "rfft f64 128"                      OFF)
option(RFFT_F64_512         "rfft f64 512"                      OFF)
option(RFFT_F64_2048        "rfft f64 2048"                     OFF)
option(RFFT_F64_8192        "rfft f64 8192"                     OFF)

option(RFFT_Q31_32          "rfft q31 32"                       OFF)
option(RFFT_Q31_64          "rfft q31 64"                       OFF)
option(RFFT_Q31_128         "rfft q31 128"                      OFF)
option(RFFT_Q31_256         "rfft q31 256"                      OFF)
option(RFFT_Q31_512         "rfft q31 512"                      OFF)
option(RFFT_Q31_1024        "rfft q31 1024"                     OFF)
option(RFFT_Q31_2048        "rfft q31 2048"                     OFF)
option(RFFT_Q31_4096        "rfft q31 4096"                     OFF)
option(RFFT_Q31_8192        "rfft q31 8192"                     OFF)

option(RFFT_Q15_32          "rfft q15 32"                       OFF)
option(RFFT_Q15_64          "rfft q15 64"                       OFF)
option(RFFT_Q15_128         "rfft q15 128"                      OFF)
option(RFFT_Q15_256         "rfft q15 256"                      OFF)
option(RFFT_Q15_512         "rfft q15 512"                      OFF)
option(RFFT_Q15_1024        "rfft q15 1024"                     OFF)
option(RFFT_Q15_2048        "rfft q15 2048"                     OFF)
option(RFFT_Q15_4096        "rfft q15 4096"                     OFF)
option(RFFT_Q15_8192        "rfft q15 8192"                     OFF)

option(DCT4_F32_128          "dct4 f32 128"                     OFF)
option(DCT4_F32_512          "dct4 f32 512"                     OFF)
option(DCT4_F32_2048         "dct4 f32 2048"                    OFF)
option(DCT4_F32_8192         "dct4 f32 8192"                    OFF)

option(DCT4_Q31_128          "dct4 q31 128"                     OFF)
option(DCT4_Q31_512          "dct4 q31 512"                     OFF)
option(DCT4_Q31_2048         "dct4 q31 2048"                    OFF)
option(DCT4_Q31_8192         "dct4 q31 8192"                    OFF)

option(DCT4_Q15_128          "dct4 q15 128"                     OFF)
option(DCT4_Q15_512          "dct4 q15 512"                     OFF)
option(DCT4_Q15_2048         "dct4 q15 2048"                    OFF)
option(DCT4_Q15_8192         "dct4 q15 8192"                    OFF)

###########################
#
# CMSIS DSP
#
###########################

add_library(arm_cortex_math STATIC)

target_include_directories(arm_cortex_math
	PUBLIC
		${PROJ_DIR}/Include
		${PROJ_DIR}/DSP/Include
)

file(GLOB CMSISDSP_HEADERS ${PROJ_DIR}/DSP/Include/*.h)
file(GLOB CMSIS_HEADERS ${PROJ_DIR}/Include/*.h)

set_target_properties(arm_cortex_math
	PROPERTIES
		PUBLIC_HEADER
			"${CMSISDSP_HEADERS}"
		PUBLIC_HEADER
			"${CMSIS_HEADERS}"
)

target_compile_definitions(arm_cortex_math PUBLIC CORTEXM)
target_compile_definitions(arm_cortex_math PRIVATE ARMCM7_DP)

set(CMSISDSP_SOURCES "" CACHE INTERNAL "")

if (CONFIGTABLE AND ALLFFT)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_ALL_FFT_TABLES)
endif()

if (CONFIGTABLE AND ALLFAST)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_ALL_FAST_TABLES)
endif()

if (CONFIGTABLE AND ARM_COS_F32)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_F32)
endif()

if (CONFIGTABLE AND ARM_COS_Q31)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_Q31)
endif()

if (CONFIGTABLE AND ARM_COS_Q15)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_Q15)
endif()

if (CONFIGTABLE AND ARM_SIN_F32)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_F32)
endif()

if (CONFIGTABLE AND ARM_SIN_Q31)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_Q31)
endif()

if (CONFIGTABLE AND ARM_SIN_Q15)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_Q15)
endif()

if (CONFIGTABLE AND ARM_SIN_COS_F32)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_F32)
endif()

if (CONFIGTABLE AND ARM_SIN_COS_Q31)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_SIN_Q31)
endif()

if (CONFIGTABLE AND ARM_LMS_NORM_Q31)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_RECIP_Q31)
endif()

if (CONFIGTABLE AND ARM_LMS_NORM_Q15)
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_RECIP_Q15)
endif()

if (CONFIGTABLE AND ARM_CMPLX_MAG_Q31 AND (MVEI OR HELIUM))
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_FAST_SQRT_Q31_MVE)
endif()

if (CONFIGTABLE AND ARM_CMPLX_MAG_Q15 AND (MVEI OR HELIUM))
    target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_FAST_SQRT_Q15_MVE)
endif()

#######################################
#
# CFFT F32
#

if (CONFIGTABLE AND CFFT_F32_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_16)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_16)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_16)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_32)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_32)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_32)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_64)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_64)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_64)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_128)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_128)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_128)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_256)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_256)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_256)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_512)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_512)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_512)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_1024)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_1024)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_1024)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_2048)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_2048)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_2048)
	endif()
endif()

if (CONFIGTABLE AND CFFT_F32_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)

	if (HELIUM OR MVEF)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_4096)
	else()
		target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_4096)
	endif()
endif()

#######################################
#
# CFFT F64
#

if (CONFIGTABLE AND CFFT_F64_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_16)
endif()

if (CONFIGTABLE AND CFFT_F64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_64)
endif()

if (CONFIGTABLE AND CFFT_F64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_64)
endif()

if (CONFIGTABLE AND CFFT_F64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_128)
endif()

if (CONFIGTABLE AND CFFT_F64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_256)
endif()

if (CONFIGTABLE AND CFFT_F64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_512)
endif()

if (CONFIGTABLE AND CFFT_F64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_1024)
endif()

if (CONFIGTABLE AND CFFT_F64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_2048)
endif()

if (CONFIGTABLE AND CFFT_F64_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_4096)
endif()

#######################################
#
# CFFT Q31
#

if (CONFIGTABLE AND CFFT_Q31_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_16)
endif()

if (CONFIGTABLE AND CFFT_Q31_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_32)
endif()

if (CONFIGTABLE AND CFFT_Q31_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_64)
endif()

if (CONFIGTABLE AND CFFT_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_128)
endif()

if (CONFIGTABLE AND CFFT_Q31_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_256)
endif()

if (CONFIGTABLE AND CFFT_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_512)
endif()

if (CONFIGTABLE AND CFFT_Q31_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_1024)
endif()

if (CONFIGTABLE AND CFFT_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_2048)
endif()

if (CONFIGTABLE AND CFFT_Q31_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_4096)
endif()

#######################################
#
# CFFT Q15
#

if (CONFIGTABLE AND CFFT_Q15_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_16)
endif()

if (CONFIGTABLE AND CFFT_Q15_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_32)
endif()

if (CONFIGTABLE AND CFFT_Q15_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_64)
endif()

if (CONFIGTABLE AND CFFT_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_128)
endif()

if (CONFIGTABLE AND CFFT_Q15_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_256)
endif()

if (CONFIGTABLE AND CFFT_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_512)
endif()

if (CONFIGTABLE AND CFFT_Q15_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_1024)
endif()

if (CONFIGTABLE AND CFFT_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_2048)
endif()

if (CONFIGTABLE AND CFFT_Q15_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_4096)
endif()

#######################################
#
# RFFT FAST F64
#

if (CONFIGTABLE AND RFFT_FAST_F64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_16)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_32)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_64)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_128)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_256)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_512)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_1024)
endif()

if (CONFIGTABLE AND RFFT_FAST_F64_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT64_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F64_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F64_2048)
endif()

#######################################
#
# RFFT FAST F32
#

if (CONFIGTABLE AND RFFT_FAST_F32_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_16)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_32)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_64)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_128)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_256)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_512)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_1024)
endif()

if (CONFIGTABLE AND RFFT_FAST_F32_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FLT_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_RFFT_F32_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_2048)
endif()

#######################################
#
# RFFT F32
#

if (CONFIGTABLE AND RFFT_F32_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND RFFT_F32_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)
	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

#######################################
#
# RFFT Q31
#

if (CONFIGTABLE AND RFFT_Q31_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_16)
endif()

if (CONFIGTABLE AND RFFT_Q31_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_32)
endif()

if (CONFIGTABLE AND RFFT_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_64)
endif()

if (CONFIGTABLE AND RFFT_Q31_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_128)
endif()

if (CONFIGTABLE AND RFFT_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_256)
endif()

if (CONFIGTABLE AND RFFT_Q31_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_512)
endif()

if (CONFIGTABLE AND RFFT_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_1024)
endif()

if (CONFIGTABLE AND RFFT_Q31_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_2048)
endif()

if (CONFIGTABLE AND RFFT_Q31_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_4096)
endif()

#######################################
#
# RFFT FAST Q15
#

if (CONFIGTABLE AND RFFT_Q15_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_16)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_16)
endif()

if (CONFIGTABLE AND RFFT_Q15_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_32)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_32)
endif()

if (CONFIGTABLE AND RFFT_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_64)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_64)
endif()

if (CONFIGTABLE AND RFFT_Q15_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_128)
endif()

if (CONFIGTABLE AND RFFT_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_256)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_256)
endif()

if (CONFIGTABLE AND RFFT_Q15_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_512)
endif()

if (CONFIGTABLE AND RFFT_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_1024)
endif()

if (CONFIGTABLE AND RFFT_Q15_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_2048)
endif()

if (CONFIGTABLE AND RFFT_Q15_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREVIDX_FXT_4096)
endif()

#######################################
#
# DCT4 F32
#

if (CONFIGTABLE AND DCT4_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_F32_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND DCT4_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_F32_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND DCT4_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_F32_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

if (CONFIGTABLE AND DCT4_F32_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_F32_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_F32)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_F32_4096)
endif()

#######################################
#
# DCT4 Q31
#

if (CONFIGTABLE AND DCT4_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q31_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
endif()

if (CONFIGTABLE AND DCT4_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q31_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
endif()

if (CONFIGTABLE AND DCT4_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q31_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
endif()

if (CONFIGTABLE AND DCT4_Q31_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q31_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q31)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q31_4096)
endif()

#######################################
#
# DCT4 Q15
#

if (CONFIGTABLE AND DCT4_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q15_128)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
endif()

if (CONFIGTABLE AND DCT4_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q15_512)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
endif()

if (CONFIGTABLE AND DCT4_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q15_2048)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
endif()

if (CONFIGTABLE AND DCT4_Q15_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_DCT4_Q15_8192)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_REALCOEF_Q15)

	# For cfft_radix4_init
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_BITREV_1024)
	target_compile_definitions(arm_cortex_math PUBLIC ARM_TABLE_TWIDDLECOEF_Q15_4096)
endif()

if (CONFIGTABLE)
	# Public because initialization for FFT may be defined in client code
	# and needs access to the table.
	target_compile_definitions(arm_cortex_math PUBLIC ARM_DSP_CONFIG_TABLES)
endif()

if (LOOPUNROLL)
	target_compile_definitions(arm_cortex_math PRIVATE ARM_MATH_LOOPUNROLL)
endif()

if (ROUNDING)
	target_compile_definitions(arm_cortex_math PRIVATE ARM_MATH_ROUNDING)
endif()

if (MATRIXCHECK)
	target_compile_definitions(arm_cortex_math PRIVATE ARM_MATH_MATRIX_CHECK)
endif()

if (AUTOVECTORIZE)
	target_compile_definitions(arm_cortex_math PRIVATE ARM_MATH_AUTOVECTORIZE)
endif()

if (NEON OR NEONEXPERIMENTAL)
	target_include_directories(arm_cortex_math PRIVATE ${SRC_DIR}/ComputeLibrary/Include)
endif()

if (FLOAT16)
	target_compile_definitions(arm_cortex_math PRIVATE ARM_MATH_FLOAT16)
endif()

if (HELIUM OR MVEF OR SUPPORT)
   target_include_directories(arm_cortex_math PRIVATE ${PROJ_DIR}/DSP/PrivateInclude)
endif()

if (SEMIHOSTING)
	target_compile_definitions(arm_cortex_math PRIVATE SEMIHOSTING)
endif()

if (BASICMATH)
	include(${SRC_DIR}/BasicMathFunctions/BasicMathFunctions.cmake)
endif()

if (COMPLEXMATH)
	include(${SRC_DIR}/ComplexMathFunctions/ComplexMathFunctions.cmake)
endif()

if (CONTROLLER)
	include(${SRC_DIR}/ControllerFunctions/ControllerFunctions.cmake)

	# Fast tables inclusion is allowed
	if (CONFIGTABLE)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_FAST_ALLOW_TABLES)
	endif()
endif()

if (FASTMATH)
	include(${SRC_DIR}/FastMathFunctions/FastMathFunctions.cmake)

	# Fast tables inclusion is allowed
	if (CONFIGTABLE)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_FAST_ALLOW_TABLES)
	endif()
endif()

if (FILTERING)
	include(${SRC_DIR}/FilteringFunctions/FilteringFunctions.cmake)

	# Fast tables inclusion is allowed
	if (CONFIGTABLE)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_FAST_ALLOW_TABLES)
	endif()
endif()

if (MATRIX)
	include(${SRC_DIR}/MatrixFunctions/MatrixFunctions.cmake)
endif()

if (STATISTICS)
	include(${SRC_DIR}/StatisticsFunctions/StatisticsFunctions.cmake)
endif()

if (SUPPORT)
	include(${SRC_DIR}/SupportFunctions/SupportFunctions.cmake)
endif()

if (TRANSFORM)
	include(${SRC_DIR}/TransformFunctions/TransformFunctions.cmake)

	# FFT tables inclusion is allowed
	if (CONFIGTABLE)
		target_compile_definitions(arm_cortex_math PUBLIC ARM_FFT_ALLOW_TABLES)
	endif()
endif()

if (FILTERING OR CONTROLLER OR FASTMATH OR TRANSFORM OR SVM OR DISTANCE)
	# Common project is adding ComputeLibrary tables used by SVM and Distance
	# when NEON is ON.
	include(${SRC_DIR}/CommonTables/CommonTables.cmake)

	if (TRANSFORM)
		# FFT tables inclusion is allowed
		if (CONFIGTABLE)
			target_compile_definitions(arm_cortex_math PUBLIC ARM_FFT_ALLOW_TABLES)
		endif()
	endif()

	if (FILTERING OR CONTROLLER OR FASTMATH)
		# Select which tables to include
		if (CONFIGTABLE)
			target_compile_definitions(arm_cortex_math PUBLIC ARM_FAST_ALLOW_TABLES)
		endif()
	endif()
endif()

if (SVM)
	include(${SRC_DIR}/SVMFunctions/SVMFunctions.cmake)
endif()

if (BAYES)
	include(${SRC_DIR}/BayesFunctions/BayesFunctions.cmake)
endif()

if (DISTANCE)
	include(${SRC_DIR}/DistanceFunctions/DistanceFunctions.cmake)
endif()

target_sources(arm_cortex_math
	PUBLIC
		${CMSISDSP_SOURCES}
)

install(TARGETS arm_cortex_math
	ARCHIVE
		DESTINATION lib
	PUBLIC_HEADER
		DESTINATION include/CMSIS
)

### Includes
# target_include_directories(CMSISDSP INTERFACE "${DSP}/Include")

# file(MAKE_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}/lib)
# set(CMSIS_INSTALL_LIB ${CMAKE_CURRENT_BINARY_DIR}/lib/libarm_cortex_math.a)

# ### Install
# add_custom_target(CMSIS_LIB_JOIN ALL
# 	DEPENDS				${CMSIS_INSTALL_TARGETS}
# 	WORKING_DIRECTORY	${CMAKE_CURRENT_BINARY_DIR}
# 	COMMAND				mkdir -p lib
# 	COMMAND				rm -f ${CMSIS_INSTALL_LIB}
# 	COMMAND				ar -rcT ${CMSIS_INSTALL_LIB} ./*/*.a
# 	BYPRODUCTS			${CMSIS_INSTALL_LIB}
# )

# add_library(CMSIS_JOINED STATIC IMPORTED GLOBAL)

# set_target_properties(CMSIS_JOINED
# 	PROPERTIES
# 	IMPORTED_LOCATION ${CMSIS_INSTALL_LIB}
# )

# target_link_libraries(CMSISDSP INTERFACE CMSIS_JOINED)

# install(FILES ${CMSIS_INSTALL_LIB}
# 	COMPONENT cmsis-dsp-libs
# 	DESTINATION lib
# )

# file(GLOB CMSIS_DSP_HEADERS ${DSP}/Include/*.h)
# file(GLOB CMSIS_HEADERS ${DSP}/../Core/Include/*.h)

# install(FILES ${CMSIS_DSP_HEADERS}
# 	COMPONENT cmsis-dsp-headers
# 	PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
# 	DESTINATION include/CMSIS/DSP
# )

# install(FILES ${CMSIS_HEADERS}
# 	COMPONENT cmsis-headers
# 	PERMISSIONS OWNER_READ OWNER_WRITE GROUP_READ WORLD_READ
# 	DESTINATION include/CMSIS
# )
