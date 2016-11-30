//
//  Use this file to import your target's public headers that you would like to expose to Swift.
//

class Ship
{
public:
    explicit Ship (int, std::string);
    void addHealth();
    void subtractHealth();
    int getHealth();
    std::string getColor();
    
private:
    int health;
    std::string color;
};
