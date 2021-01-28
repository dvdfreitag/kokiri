cmake_minimum_required (VERSION 3.6)

list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_const_structs.c)

if (NEON OR NEONEXPERIMENTAL)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_cl_tables.c)
endif()

if (HELIUM OR MVEF)
	list(APPEND CMSISDSP_SOURCES ${CMAKE_CURRENT_LIST_DIR}/arm_mve_tables.c)
endif()
