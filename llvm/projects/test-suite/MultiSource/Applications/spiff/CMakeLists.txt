set(PROG spiff)
set(RUN_OPTIONS ${CMAKE_CURRENT_SOURCE_DIR}/Sample.3 ${CMAKE_CURRENT_SOURCE_DIR}/Sample.4)
if(ARCH STREQUAL "XCore")
  if(NOT DEFINED SMALL_PROBLEM_SIZE)
    set(XCORE_TARGET_NEEDS_MEMORY 1024)
  endif()
endif()
llvm_multisource()
