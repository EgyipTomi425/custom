add_library(custom)

include("${CMAKE_CURRENT_SOURCE_DIR}/config.cmake")

target_sources(custom
        PUBLIC
        FILE_SET CXX_MODULES FILES
            custom.cppm
)

# Your custom libraries are here
# You can use config.cmake variables to make it optional
if(TEMPLATE)
    add_subdirectory(template)
    target_link_libraries(custom PUBLIC template)
endif()
# Private and optional: CMake never downloads the SDK or requests credentials.
option(GGE_SDK "Build the private SDK when its checkout is available" ON)
if(GGE_SDK AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/gge_sdk/CMakeLists.txt"
        AND EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/gge_sdk/Echter_Websockets/CMakeLists.txt")
    add_subdirectory(gge_sdk EXCLUDE_FROM_ALL)
    target_link_libraries(custom PUBLIC gge_sdk)
    target_compile_definitions(custom PUBLIC GGE_SDK)
elseif(GGE_SDK)
    message(STATUS "Private gge_sdk or its WebSocket submodule is unavailable; skipping SDK.")
endif()
