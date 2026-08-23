cmake_minimum_required(VERSION 3.16)

project(TodoList VERSION 0.2 LANGUAGES CXX)

option(BUILD_TESTS "Build tests" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS
    Quick
    QuickControls2
    Sql
    ShaderTools
)

qt_standard_project_setup(REQUIRES 6.11)

qt_add_library(TodoListCore STATIC
    backend/database/database.cpp
    backend/database/database.h
    backend/manager/taskManager.cpp
    backend/manager/taskManager.h
    backend/model/listModel.h
    backend/model/listModel.cpp
    backend/task/task.h
    backend/proxyModel/proxyModel.h
    backend/proxyModel/proxyModel.cpp
    backend/controller/appController.h
    backend/controller/appController.cpp
    backend/worker/taskWorker.h
    backend/worker/taskWorker.cpp
    backend/task/operationStatus.h
    backend/database/databaseMode.h
)

target_link_libraries(TodoListCore
    PUBLIC
    Qt6::Core
    Qt6::Sql
)

target_include_directories(TodoListCore PUBLIC
    ${CMAKE_CURRENT_SOURCE_DIR}/backend
)

qt_add_executable(TodoListApp
    frontend/main.cpp
)

qt6_add_shaders(TodoListApp "my_liqui_shader"
    PREFIX
    "local_shader"
    BASE
    "frontend/shaders"
    FILES
    "frontend/shaders/LiquiGradient.frag"



)
qt_add_qml_module(TodoListApp
    URI TodoList
    QML_FILES
    frontend/Main.qml
    frontend/screens/MainScreen.qml
    frontend/components/ActionButton.qml
    frontend/components/TaskCard.qml
    frontend/components/TaskInput.qml
    frontend/components/AnimatedBackground.qml
    frontend/screens/SplashScreen.qml
    frontend/components/CustomCheckbox.qml
    frontend/components/TaskList.qml
    frontend/components/Notification.qml
    frontend/components/SearchField.qml
    frontend/components/PaginationPanel.qml
    frontend/components/TaskScroll.qml
)

target_link_libraries(TodoListApp
    PRIVATE
    TodoListCore
    Qt6::Quick
    Qt6::QuickControls2
)

target_sources(TodoListApp PRIVATE
   frontend/image/logo.icns
)

set_source_files_properties(
    frontend/image/logo.icns
    PROPERTIES
    MACOSX_PACKAGE_LOCATION "Resources"
)

if(BUILD_TESTS)

    enable_testing()

    qt_add_executable(TodoListTests
        test/main.cpp
        test/database/databaseTest.cpp
        test/database/databaseTest.h
        test/manager/managerTest.cpp
        test/manager/managerTest.h
        test/listModel/listModelTest.cpp
        test/listModel/listModelTest.h
        test/proxyModel/proxyModelTest.cpp
        test/proxyModel/proxyModelTest.h
    )

    target_link_libraries(TodoListTests
        PRIVATE
        TodoListCore
        Qt6::Test
    )

    add_test(NAME TodoListTests COMMAND TodoListTests)


    set_target_properties(TodoListTests PROPERTIES
        RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/tests
    )

endif()

set_target_properties(TodoListApp PROPERTIES

    MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION}
    MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION_MAJOR}.${PROJECT_VERSION_MINOR}
    MACOSX_BUNDLE TRUE
    WIN32_EXECUTABLE TRUE
)


install(TARGETS TodoListApp
    BUNDLE DESTINATION .
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
