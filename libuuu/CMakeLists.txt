cmake_minimum_required(VERSION 3.4)

set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_SKIP_RPATH ON)

find_package(BZip2 REQUIRED)
find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBUSB REQUIRED libusb-1.0>=1.0.16)
pkg_check_modules(LIBZSTD REQUIRED libzstd)
find_package(Threads)
pkg_check_modules(TINYXML2 REQUIRED tinyxml2)

include_directories(${LIBUSB_INCLUDE_DIRS} ${LIBZSTD_INCLUDE_DIRS} ${UUUOPENSLL_INCLUDE_DIR} ${TINYXML2_INCLUDE_DIR} include)

if (NOT MSVC)
set(CMAKE_CXX_FLAGS_DEBUG "-g -Wall -Wstrict-aliasing -Wextra ${UUUSSL}")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -O2 ${UUUSSL}")
endif()

set(SOURCES
	error.cpp
	buffer.cpp
	cmd.cpp
	config.cpp
	notify.cpp
	sdps.cpp
	trans.cpp
	usbhotplug.cpp
	version.cpp
	sdp.cpp
	gitversion.h
	fastboot.cpp
	zip.cpp
	fat.cpp
	tar.cpp
	rominfo.cpp
	http.cpp
	hidreport.cpp
	sparse.cpp
	bmap.cpp
)

set(generated_files_dir "${CMAKE_BINARY_DIR}/libuuu/gen")
set(gitversion_h "${generated_files_dir}/gitversion.h")

if (NOT MSVC)
add_custom_command(
	OUTPUT gitversion.h
	PRE_BUILD
	COMMAND mkdir -p ${generated_files_dir}
	COMMAND sh -c 'cd ${CMAKE_CURRENT_SOURCE_DIR} && ./gen_ver.sh "${gitversion_h}"'

)
else ()
add_custom_command(
	OUTPUT gitversion.h
	PRE_BUILD
	COMMAND ./msvc/createversion.bat libuuu
	WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/..
)
endif ()
include_directories(${generated_files_dir})

#add_library( uuc SHARED ${SOURCES} ))
add_library( uuc_s STATIC ${SOURCES} )
