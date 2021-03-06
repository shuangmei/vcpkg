include(vcpkg_common_functions)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO mdadams/jasper
    REF d10a710f31da3d079a984d35ff6cc82a853d25d7 # version-2.0.20
    SHA512 b581268d9a36ef4756aa0ec74ab4a96624e8cb6d03753e6f21148b6d2f62c081d434b319466f29c2cca34c547543ad5d41f68b838f3e131bbf01bab960d0f51c
    HEAD_REF master
)

if(VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
    set(JAS_ENABLE_SHARED ON)
else()
    set(JAS_ENABLE_SHARED OFF)
endif()

vcpkg_configure_cmake(
    SOURCE_PATH ${SOURCE_PATH}
    PREFER_NINJA
    OPTIONS
        -DJAS_ENABLE_AUTOMATIC_DEPENDENCIES=OFF
        -DJAS_ENABLE_LIBJPEG=ON
        -DJAS_ENABLE_DOC=OFF
        -DJAS_ENABLE_PROGRAMS=OFF
        -DJAS_ENABLE_SHARED=${JAS_ENABLE_SHARED}
    OPTIONS_DEBUG
        -DCMAKE_DEBUG_POSTFIX=d # Due to CMakes FindJasper
)

vcpkg_install_cmake()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/lib/pkgconfig)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/share)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/lib/pkgconfig)
file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/share)

file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/jasper RENAME copyright)
