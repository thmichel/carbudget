/**
 * CarBudget, Sailfish application to manage car cost
 *
 * Copyright (C) 2014 Fabien Proriol
 *
 * This file is part of CarBudget.
 *
 * CarBudget is free software: you can redistribute it and/or modify it under the terms of the
 * GNU General Public License as published by the Free Software Foundation, either version 3 of the
 * License, or (at your option) any later version.
 *
 * CarBudget is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
 *
 * See the GNU General Public License for more details. You should have received a copy of the GNU
 * General Public License along with CarBudget. If not, see <http://www.gnu.org/licenses/>.
 *
 * Authors: Fabien Proriol
 */


import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.carbudget 1.0


Page {
    allowedOrientations: Orientation.All

    SilicaFlickable {

        VerticalScrollDecorator {}

        id: budgetView
        anchors.fill: parent
        leftMargin: Theme.paddingMedium
        rightMargin: Theme.paddingMedium
        contentHeight:dataColumn.height
        Column {
            id: dataColumn
            //anchors.fill:parent
            width: parent.width- Theme.paddingMedium - Theme.paddingMedium
            PageHeader {
                title: qsTr("Statistics")
            }

            Row {
                id:odoRow
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("ODO ")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.maxdistance
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("In Budget")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.maxdistance - manager.car.mindistance
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                id: fuelRow
                width: parent.width
                Text {
                    text : qsTr("Fuel")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Row {
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Total: ")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.fueltotal.toFixed(2) + " l"
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Average: ")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.consumption.toFixed(2) + " l"
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Min:")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.consumptionmin.toFixed(2) + " l"
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Max:")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text :  manager.car.consumptionmax.toFixed(2) + " l"
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                id:costsRow
                width: parent.width
                Text {
                    text : qsTr("Costs")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Row {
                id:fuelcostsRow
                width: parent.width
                Rectangle {
                    height: fueltext.height
                    width: parent.width
                    color: "transparent"
                    Text {
                        id: fueltext
                        width:parent.width/2
                        text : qsTr("Fuel:")
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        anchors.right:parent.right
                        width:parent.width/2
                        text : manager.car.budget_fuel_total.toFixed(2) + " " + manager.car.currency
                        font.family: "monospaced"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignRight
                    }
                    MouseArea {
                        id:fuelcostsMouse
                        anchors.fill:parent
                        onClicked: pageStack.push(Qt.resolvedUrl("FuelStatistics.qml"))
                    }
                }
            }

            Row {
                id: billcostsRow
                width: parent.width
                Rectangle {
                    height: billtext.height
                    width: parent.width
                    color: "transparent"

                    Text {
                        id: billtext
                        width:parent.width/2
                        text : qsTr("Bills:")
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        width:parent.width/2
                        anchors.right:parent.right
                        text : manager.car.budget_cost_total.toFixed(2) + " " + manager.car.currency
                        font.family: "monospaced"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignRight
                    }
                    MouseArea {

                        id: billcostsMouse
                        anchors.fill: parent
                        onClicked: pageStack.push(Qt.resolvedUrl("CostStatistics.qml"))
                    }
                }
            }
            Row {
                id: totalcostsRow
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Total:")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text : manager.car.budget_total.toFixed(2) + " " + manager.car.currency
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
            Row {
                id: per100Row
                width: parent.width
                Text {
                    text : qsTr("Costs per 100 Km")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeMedium
                    font.bold: true
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
            }
            Row {
                id:fuelper100Row
                width: parent.width
                Rectangle {
                    height: fuelbtext.height
                    width: parent.width
                    color: "transparent"

                    Text {
                        id: fuelbtext
                        width:parent.width/2
                        text : qsTr("Fuel:")
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        width:parent.width/2
                        anchors.right:parent.right
                        text : manager.car.budget_fuel.toFixed(2) + " " + manager.car.currency
                        font.family: "monospaced"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignRight
                    }
                    MouseArea {
                        id:fuelper100Mouse
                        anchors.fill:parent
                        onClicked: pageStack.push(Qt.resolvedUrl("Fuelper100Statistics.qml"))
                    }
                }
            }
            Row {
                id:billsper100Row
                width: parent.width
                Rectangle {
                    height: billbtext.height
                    width: parent.width
                    color: "transparent"

                    Text {
                        id: billbtext
                        width:parent.width/2
                        text : qsTr("Bills:")
                        font.family: Theme.fontFamily
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignLeft
                    }
                    Text {
                        width:parent.width/2
                        anchors.right:parent.right
                        text : manager.car.budget_cost.toFixed(2) + " " + manager.car.currency
                        font.family: "monospaced"
                        font.pixelSize: Theme.fontSizeSmall
                        color: Theme.primaryColor
                        horizontalAlignment: Text.AlignRight
                    }
                    MouseArea {
                        id: billsper100Mouse
                        anchors.fill: parent
                        onClicked: pageStack.push(Qt.resolvedUrl("Costper100Statistics.qml"))
                    }
                }
            }
            Row {
                id: totalper100Row
                width: parent.width
                Text {
                    width:parent.width/2
                    text : qsTr("Total:")
                    font.family: Theme.fontFamily
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignLeft
                }
                Text {
                    width:parent.width/2
                    text : manager.car.budget.toFixed(2) + " " + manager.car.currency
                    font.family: "monospaced"
                    font.pixelSize: Theme.fontSizeSmall
                    color: Theme.primaryColor
                    horizontalAlignment: Text.AlignRight
                }
            }
        }
    }
}
