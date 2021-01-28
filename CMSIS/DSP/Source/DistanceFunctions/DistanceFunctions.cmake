cmake_minimum_required (VERSION 3.6)

file(GLOB SRCS ${CMAKE_CURRENT_LIST_DIR}/*.c)
list(APPEND CMSISDSP_SOURCES "${SRCS}")
