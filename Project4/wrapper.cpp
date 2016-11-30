//
//  wrapper.cpp
//  MeteorRush
//
//  Created by Evan Zhao on 11/29/16.
//  Copyright © 2016 Evan Zhao. All rights reserved.
//

#include <stdio.h>
#include "Ship.hpp"

Ship s = Ship(5, "red");

// extern "C" will cause the C++ compiler
// (remember, this is still C++ code!) to
// compile the function in such a way that
// it can be called from C
// (and Swift).
extern "C" int getHealth()
{
    return s.getHealth();
}

extern "C" void addHealth(int inc)
{
    s.addHealth(inc);
}

extern "C" void subtractHealth(int inc)
{
    s.subtractHealth(inc);
}

extern "C" int randInt()
{
    return 1;
}

