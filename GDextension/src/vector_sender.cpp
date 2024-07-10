
#include <iostream>



int main() {
    float a = 0.0f;
    float b = 10.0f; // 固定值
    float c = 0.0f;  // 固定值

    while (true) {
        a += 1.0f; // 向右平移
        std::cout << a << " " << b << " " << c << std::endl;
        std::cout.flush();
    }
    return 0;
}

