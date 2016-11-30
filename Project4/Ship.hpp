//
//  Ship.hpp
//  MeteorRush
//
//  Created by Evan Zhao on 11/29/16.
//  Copyright © 2016 Evan Zhao. All rights reserved.
//

#ifndef Ship_hpp
#define Ship_hpp

#include <iostream>
#include <stdio.h>
#pragma once

class Ship
{
public:
    explicit Ship (int, std::string);
    void addHealth(int);
    void subtractHealth(int);
    int getHealth();
    std::string getColor();
    bool isDead();
    void setHealth(int);
    
private:
    int health;
    std::string color;
};

#endif /* Ship_hpp */
