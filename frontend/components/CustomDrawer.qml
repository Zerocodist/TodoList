import QtQuick
import QtQuick.Controls

Item {

       id: main

       property int drawerWidth: 200

       anchors.fill: parent

       Drawer
       {
              id: drawer

              width: drawerWidth
              height: parent.height

              edge: Qt.LeftEdge

              Item
              {
                     anchors.fill: parent
                     anchors.margins: 20

                     Column
                     {
                            anchors.fill: parent
                            spacing: 20

                            ActionButton
                            {
                                   buttonHeight: 40
                                   buttonText: "About project ℹ"

                                   onClicked:
                                   {
                                          infoPopup.infoPopupText =
                                                        "This is 2.0 version from Todo List.\n"
                                                  + "No updates are planned in the near fututre"
                                          infoPopup.showPopup()

                                          drawer.close()
                                   }
                            }

                            ActionButton
                            {
                                   buttonHeight: 40
                                   buttonText: "About author 👤"

                                   onClicked:
                                   {
                                          infoPopup.infoPopupText =
                                                        "I'm Zero and i'm 18 y.o..\n"
                                                 + "My stack: Qt,C++,SQL(SQLite),CMake,GLSl.\n"
                                                 + "I want to get my first offer, so i built this project.\n"
                                                 + "You can also share me your idea for my project, click to button telegram :)"
                                          infoPopup.showPopup()

                                          drawer.close()
                                   }
                            }

                            ActionButton
                            {
                                   buttonHeight: 40
                                   buttonText: "GitHub 💼"

                                   onClicked:
                                   {
                                          Qt.openUrlExternally(
                                          Qt.url("https:/github.com/Zerocodist")
                                          )
                                   }
                            }

                            ActionButton
                            {
                                   buttonHeight: 40
                                   buttonText: "Telegram 💬"

                                   onClicked:
                                   {
                                          Qt.openUrlExternally(
                                          Qt.url("https://t.me/zerocodist")
                                          )
                                   }
                            }
                     }
              }
       }

       ActionButton
       {
              buttonText: "☰"

              buttonHeight: 40
              buttonWidth: 100

              onClicked:
              {
                     drawer.open()
              }
       }

       InfoPopup
       {
              id: infoPopup
       }
}
