cmake_minimum_required (VERSION 3.6)

if (NOT CONFIGTABLE OR ALLFAST OR ARM_COS_F32)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cos_f32.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_COS_Q15)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cos_q15.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_COS_Q31)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cos_q31.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_SIN_F32)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_sin_f32.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_SIN_Q15)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_sin_q15.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_SIN_Q31)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_sin_q31.c)
endif()

list(APPEND CMSISDSP_SOURCES
	${CMAKE_CURRENT_LIST_DIR}/arm_sqrt_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_sqrt_q31.c
	${CMAKE_CURRENT_LIST_DIR}/arm_vlog_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_vexp_f32.c
)
