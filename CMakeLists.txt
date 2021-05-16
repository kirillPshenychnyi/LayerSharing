cmake_minimum_required(VERSION 3.15)
project(CALayers)

SET(BASEPATH "${CMAKE_SOURCE_DIR}")
INCLUDE_DIRECTORIES("${BASEPATH}")

set(CMAKE_CXX_STANDARD 14)

add_executable(CALayers main.mm rendering/remote_layer_api.h
        rendering/client_gl_layer.mm rendering/client_gl_layer.h
        ipc/ipc.h ipc/ipc.mm rendering/server_main_window.h
        rendering/server_main_window.mm
        application/host_app.mm
        application/host_app.h
        application/renderer_app.mm
        application/renderer_app.h
        application/app_delegate.h
        application/app_delegate.mm)

set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -framework Cocoa -framework QuartzCore -framework OpenGL")