//
//  Ship.cpp
//  MeteorRush
//
//  Created by Evan Zhao on 11/29/16.
//  Copyright © 2016 Evan Zhao. All rights reserved.
//

#include "Ship.hpp"

#include <iostream>
#include "Ship.hpp"
using namespace std;

Ship::Ship(int h, std::string c) {
    health = h;
    color = c;
}

void Ship::addHealth() {
    health = health + 10;
}
void Ship::subtractHealth() {
    health = health - 10;
}
int Ship::getHealth() {
    return health;
}
std::string Ship::getColor() {
    return color;
}
