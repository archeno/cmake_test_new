install(
    TARGETS hello_exe
    RUNTIME COMPONENT hello_Runtime
)

if(PROJECT_IS_TOP_LEVEL)
  include(CPack)
endif()
