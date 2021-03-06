include(ExternalProject)

set(ENABLE_STATIC_JSC ON)
set(ENABLE_EXPERIMENTAL_FEATURES ON)
set(SHARED_CORE OFF)
set(ENABLE_API_TESTS OFF)

set(WEBKIT_ARGS
    -DPORT=JSCOnly
    -DENABLE_STATIC_JSC=${ENABLE_STATIC_JSC}
    -DENABLE_EXPERIMENTAL_FEATURES=${ENABLE_EXPERIMENTAL_FEATURES}
    -DSHARED_CORE=${SHARED_CORE}
    -DENABLE_API_TESTS=OFF
    -DCMAKE_BUILD_TYPE=${CMAKE_BUILD_TYPE})

ExternalProject_Add(webkit
    SOURCE_DIR ${CMAKE_SOURCE_DIR}/vendor/webkit
    CMAKE_ARGS ${WEBKIT_ARGS}
    STEP_TARGETS build
    EXCLUDE_FROM_ALL TRUE)

add_library(JavaScriptCore STATIC IMPORTED)
set_target_properties(JavaScriptCore PROPERTIES IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/webkit-prefix/src/webkit-build/lib/libJavaScriptCore.a)
add_library(WTF STATIC IMPORTED)
set_target_properties(WTF PROPERTIES IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/webkit-prefix/src/webkit-build/lib/libWTF.a)
add_library(bmalloc STATIC IMPORTED)
set_target_properties(bmalloc PROPERTIES IMPORTED_LOCATION ${CMAKE_BINARY_DIR}/webkit-prefix/src/webkit-build/lib/libbmalloc.a)
set_target_properties(bmalloc PROPERTIES IMPORTED_LINK_INTERFACE_LIBRARIES -ldl)

SET(JAVASCRIPTCORE_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/vendor/webkit/Source)

SET(JAVASCRIPTCORE_INCLUDE_DIR
    ${CMAKE_BINARY_DIR}/webkit-prefix/src/webkit-build/
    ${JAVASCRIPTCORE_INCLUDE_DIR}
    ${JAVASCRIPTCORE_INCLUDE_DIR}/bmalloc
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/heap
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/parser
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/domjit
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/dfg
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/profiler
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/interpreter
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/runtime
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/jit
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/assembler
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/wasm
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/wasm/js
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/bytecode
    ${JAVASCRIPTCORE_INCLUDE_DIR}/JavaScriptCore/API
    ${JAVASCRIPTCORE_INCLUDE_DIR}/WTF
    ${WTF_INCLUDE_DIR}
)

SET(JAVASCRIPTCORE_LIBRARY)

SET(JAVASCRIPTCORE_LIBRARIES
    ${JAVASCRIPTCORE_LIBRARY}
    ${WTF_LIBRARY}
    ${BMALLOC_LIBRARY}
    -ldl)

SET(BEAST_INCLUDE_DIR ${CMAKE_SOURCE_DIR}/vendor/beast/include)
