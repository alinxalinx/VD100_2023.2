# Copyright (C) 2023 Advanced Micro Devices, Inc.  All rights reserved.
# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.16)

include(${CMAKE_SOURCE_DIR}/Empty_applicationExample.cmake)
include(${CMAKE_CURRENT_SOURCE_DIR}/UserConfig.cmake)
set(APP_NAME mipi_lwip)
project(${APP_NAME})

find_package(common)
enable_language(C ASM CXX)
collect(PROJECT_LIB_DEPS xilstandalone)
collect(PROJECT_LIB_DEPS xil)
collect(PROJECT_LIB_DEPS xiltimer;lwip213)
































collect(PROJECT_LIB_DEPS lwip213)
collect(PROJECT_LIB_DEPS gcc)
collect(PROJECT_LIB_DEPS c)
collector_list (_deps PROJECT_LIB_DEPS)
list (APPEND _deps ${USER_LINK_LIBRARIES})

if(CMAKE_EXPORT_COMPILE_COMMANDS)
    set(CMAKE_CXX_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_CXX_IMPLICIT_INCLUDE_DIRECTORIES})
    set(CMAKE_C_STANDARD_INCLUDE_DIRECTORIES ${CMAKE_C_IMPLICIT_INCLUDE_DIRECTORIES})
endif()
collect (PROJECT_LIB_SOURCES si5324.c)
collect (PROJECT_LIB_SOURCES lwip_app.c)
collect (PROJECT_LIB_SOURCES i2c_access.c)
collect (PROJECT_LIB_SOURCES vtc.c)
collect (PROJECT_LIB_SOURCES platform_zynqmp.c)
collect (PROJECT_LIB_SOURCES platform_mb.c)
collect (PROJECT_LIB_SOURCES cam_config.c)
collect (PROJECT_LIB_SOURCES platform.c)
collect (PROJECT_LIB_SOURCES i2c/PS_i2c.c)
collect (PROJECT_LIB_SOURCES sfp.c)
collect (PROJECT_LIB_SOURCES demosaic/demosaic.c)
collect (PROJECT_LIB_SOURCES demosaic/xv_demosaic.c)
collect (PROJECT_LIB_SOURCES vdma.c)
collect (PROJECT_LIB_SOURCES platform_zynq.c)
collect (PROJECT_LIB_SOURCES iic_phyreset.c)
collect (PROJECT_LIB_SOURCES zynq_interrupt.c)
collect (PROJECT_LIB_SOURCES display_demo.c)
collector_list (_sources PROJECT_LIB_SOURCES)
linker_gen("${CMAKE_CURRENT_SOURCE_DIR}/linker_files/")
string(APPEND CMAKE_C_FLAGS ${USER_COMPILE_OPTIONS})
string(APPEND CMAKE_CXX_FLAGS ${USER_COMPILE_OPTIONS})
string(APPEND CMAKE_C_LINK_FLAGS ${USER_LINK_OPTIONS})
string(APPEND CMAKE_CXX_LINK_FLAGS ${USER_LINK_OPTIONS})
set_source_files_properties(${_sources} OBJECT_DEPENDS "${CMAKE_LIBRARY_PATH}/*.a")
add_executable(${APP_NAME}.elf ${_sources})
set_target_properties(${APP_NAME}.elf PROPERTIES LINK_DEPENDS ${CMAKE_SOURCE_DIR}/lscript.ld)
target_link_libraries(${APP_NAME}.elf -Wl,-T -Wl,\"${CMAKE_SOURCE_DIR}/lscript.ld\" -L\"${CMAKE_SOURCE_DIR}/\" -L\"${CMAKE_LIBRARY_PATH}/\" -L\"${USER_LINK_DIRECTORIES}/\" -Wl,--start-group,-l${_deps} -Wl,--end-group)
target_compile_definitions(${APP_NAME}.elf PUBLIC ${USER_COMPILE_DEFINITIONS})
print_elf_size(CMAKE_SIZE ${APP_NAME})
target_include_directories(${APP_NAME}.elf PUBLIC "${CMAKE_BINARY_DIR}/include")
if (${NON_YOCTO})
   set (INCLUDE_DIRS
       "${CMAKE_INCLUDE_PATH}/include/"
       "${CMAKE_BINARY_DIR}/include")
   target_include_directories(${APP_NAME}.elf PUBLIC ${INCLUDE_DIRS} ${USER_INCLUDE_DIRECTORIES})
endif()
