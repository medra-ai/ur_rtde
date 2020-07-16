# - Config file for the ur_rtde package

# Compute paths
get_filename_component(URRTDE_CMAKE_DIR "${CMAKE_CURRENT_LIST_FILE}" PATH)

# Our library dependencies (contains definitions for IMPORTED targets)
if(NOT TARGET ur_rtde)
  include("${URRTDE_CMAKE_DIR}/ur_rtdeTargets.cmake")
endif()

include("${URRTDE_CMAKE_DIR}/ur_rtdeBuildConfig.cmake")
if(IS_WINDOWS_INSTALLER)
  #find static filepath properties
  get_target_property(I_DIR ur_rtde::rtde INTERFACE_INCLUDE_DIRECTORIES)
  get_target_property(L_LIBS ur_rtde::rtde INTERFACE_LINK_LIBRARIES)

  #find boost path to be replaced
  set(boost_DIR ${I_DIR})
  list(FILTER boost_DIR INCLUDE REGEX "/boost.*")
  get_filename_component(MOD_ROOT ${boost_DIR} NAME)
  set(regex "${boost_DIR}\/[a-z0-9.-]*")
  string(REGEX MATCH "${regex}" boost_LIB_DIR ${L_LIBS})

  #replace boost path
  string(REPLACE "${boost_DIR}" "${URRTDE_CMAKE_DIR}/../../include/ext" I_DIR "${I_DIR}")
  string(REPLACE "${boost_LIB_DIR}" "${URRTDE_CMAKE_DIR}/.." L_LIBS "${L_LIBS}")
  set_target_properties(ur_rtde::rtde PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${I_DIR}"
      INTERFACE_LINK_LIBRARIES  "${L_LIBS}"
  )
endif()
