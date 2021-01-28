cmake_minimum_required (VERSION 3.6)

# MVE code is using a table for computing the fast sqrt arm_cmplx_mag_q31
# There is the possibility of not compiling this function and not including
# the table.
if (NOT CONFIGTABLE OR ALLFAST OR ARM_CMPLX_MAG_Q31 OR (NOT HELIUM AND NOT MVEI))
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_q31.c)
endif()

if (NOT CONFIGTABLE OR ALLFAST OR ARM_CMPLX_MAG_Q15 OR (NOT HELIUM AND NOT MVEI))
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_q15.c)
endif()

list(APPEND CMSISDSP_SOURCES
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_conj_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_conj_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_conj_q31.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_dot_prod_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_dot_prod_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_dot_prod_q31.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_squared_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_squared_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mag_squared_q31.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_cmplx_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_cmplx_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_cmplx_q31.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_real_f32.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_real_q15.c
	${CMAKE_CURRENT_LIST_DIR}/arm_cmplx_mult_real_q31.c
)
