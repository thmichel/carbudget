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


#include "tank.h"
#include <QDebug>
#include <car.h>
#include <carmanager.h>

Tank::Tank(Car *parent) :
    CarEvent(parent),
    _quantity(0),
    _price(0),
    _full(true),
    _station(0),
    _fueltype(0),
    _note("")
{
    connect(this,SIGNAL(distanceChanged()), SIGNAL(consumptionChanged()));
}

Tank::Tank(QDate date, unsigned int distance, double quantity, double price, bool full, unsigned int fueltype, unsigned int station, unsigned int id, QString note, Car *parent):
    CarEvent(date, distance, id, parent),
    _quantity(quantity),
    _price(price),
    _full(full),
    _station(station),
    _fueltype(fueltype),
    _note(note)
{
    connect(this,SIGNAL(distanceChanged()), SIGNAL(consumptionChanged()));
}


double Tank::quantity() const
{
    return _quantity;
}

void Tank::setQuantity(double quantity)
{
    _quantity = quantity;
    emit quantityChanged(quantity);
    emit distanceChanged();
}

double Tank::price() const
{
    return this->_price;
}

double Tank::priceu() const
{
    if (_quantity == 0) return 0;
    return _price / _quantity;
}

void Tank::setPrice(double price)
{
    _price = price;
    emit priceChanged(price);
    emit priceuChanged(this->priceu());
}

bool Tank::full() const
{
    return _full;
}

void Tank::setFull(bool full)
{
    _full = full;
    emit fullChanged(full);
}

QString Tank::stationname() const
{
    return _car->getStationName(_station);
}

double Tank::consumption() const
{
    if (!full()) return 0.0;
    const Tank *previous = _car->previousTank(_distance);
    double quant = this->quantity();
    while(previous != NULL)
    {
        if (!(previous->full()))
        {
            qDebug() << "prevous distance is " << previous->quantity();
            quant += previous->quantity();
            previous = _car->previousTank(previous->distance());
        }
        else break;
    }
    if (previous==NULL) return 0.0;
    if (_distance ==previous->distance()) return 0.0;
    return quant / ((_distance - previous->distance()) / 100.0);
}

unsigned int Tank::newDistance() const
{
    const Tank *previous = _car->previousTank(_distance);
    if(previous == NULL)
        return 0;
    return _distance - previous->distance();
}

unsigned int Tank::station() const
{
    return _station;
}

void Tank::setStation(unsigned int station)
{
    _station = station;
    emit stationChanged();
}

QString Tank::fueltypename() const
{
    return _car->getFueltypeName(_fueltype);
}

unsigned int Tank::fueltype() const
{
    return _fueltype;
}

void Tank::setFueltype(unsigned int fueltype)
{
    _fueltype = fueltype;
    emit fueltypeChanged();
}

QString Tank::note() const
{
    return _note;
}

void Tank::setNote(QString note)
{
    _note = note;
    emit noteChanged();
}

void Tank::save()
{
    if(_eventid == 0)
    {
        _eventid = saveevent();
        if(_eventid)
        {
            QSqlQuery query(_car->db);
            QString sql = QString("INSERT INTO TankList (event,quantity,price,full,station,fueltype,note) VALUES(%1,%2,%3,%4,%5,%6,'%7')").arg(_eventid).arg(_quantity).arg(_price).arg(_full).arg(_station).arg(_fueltype).arg(_note);
            if(query.exec(sql))
            {
                qDebug() << "Create Tank in database with id " << _eventid;
                _car->db.commit();
            }
            else _eventid = 0;
        }

        if(_eventid == 0)
        {
            qDebug() << "Error during Create Tank in database";
            _car->db.rollback();
        }
    }
    else
    {
        if(saveevent())
        {
            QSqlQuery query(_car->db);
            QString sql = QString("UPDATE TankList SET quantity=%1, price=%2, full=%3, station=%4, fueltype=%5, note='%6' WHERE event=%7;").arg(_quantity).arg(_price).arg(_full).arg(_station).arg(_fueltype).arg(_note).arg(_eventid);
            if(query.exec(sql))
            {
                qDebug() << "Update Tank in database with id " << _eventid;
                _car->db.commit();
            }
            else
            {
                qDebug() << "Error during Update Tank in database";
                qDebug() << query.lastError();
            }
        }
        else
        {
            qDebug() << "Error during Update Tank in database";
        }
    }
}

void Tank::remove()
{
    QSqlQuery query(_car->db);
    QString sql = QString("DELETE FROM TankList WHERE event=%1;").arg(_eventid);
    if(query.exec(sql))
    {
        if(delevent())
        {
            qDebug() << "DELETE Tank in database with id " << _eventid;
            _car->db.commit();
            return;
        }
    }
    qDebug() << "Error during DELETE Tank in database";
    qDebug() << query.lastError();
    _car->db.rollback();
}
