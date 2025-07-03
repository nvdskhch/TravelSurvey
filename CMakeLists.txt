cmake_minimum_required(VERSION 3.16)

project(TravelSurvey VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(CMAKE_PREFIX_PATH "C:/Qt/6.9.0/mingw_64/lib/cmake")

message(STATUS "Using CMake from: ${CMAKE_COMMAND}")

find_package(Qt6 6.9 REQUIRED COMPONENTS Quick Core Test Gui)
if (NOT Qt6_FOUND)
    message(FATAL_ERROR "Qt6 не найден. Убедитесь, что Qt 6.9 установлен и путь указан в CMAKE_PREFIX_PATH.")
endif()

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

# Основное приложение
qt_add_executable(appTravelSurvey
    main.cpp
    surveymodel.cpp
    surveymodel.h
    qml.qrc
    HomePage.qml
    BookingPage.qml
    TripsPage.qml
    ManualBookingPage.qml
    SurveyPage.qml
    ResultPage.qml
)

target_link_libraries(appTravelSurvey
    PRIVATE Qt6::Quick Qt6::Core Qt6::Gui
)

set_target_properties(appTravelSurvey PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

if (WIN32)
    set_target_properties(appTravelSurvey PROPERTIES
        WIN32_EXECUTABLE TRUE
    )
elseif (APPLE)
    set_target_properties(appTravelSurvey PROPERTIES
        MACOSX_BUNDLE TRUE
    )
endif()

# Тестовый проект
qt_add_executable(testTravelSurvey
    tst_surveymodel.cpp
    surveymodel.cpp
    surveymodel.h
)

target_link_libraries(testTravelSurvey
    PRIVATE Qt6::Test Qt6::Core Qt6::Gui
)

set_target_properties(testTravelSurvey PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_BINARY_DIR}/bin"
)

enable_testing()
add_test(NAME TestSurveyModel COMMAND testTravelSurvey)
