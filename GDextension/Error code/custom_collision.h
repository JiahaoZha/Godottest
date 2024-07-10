#ifndef CUSTOM_COLLISION_H
#define CUSTOM_COLLISION_H

#include <godot_cpp/classes/node2d.hpp>
#include <godot_cpp/classes/rigid_body2d.hpp>
#include <godot_cpp/core/class_db.hpp>
#include <godot_cpp/variant/vector2.hpp>

namespace godot {

    class CustomCollision : public Node2D {  // 修正为继承 Node2D
        GDCLASS(CustomCollision, Node2D)  // 修正为 Node2D

    private:
        RigidBody2D* body_a;
        RigidBody2D* body_b;
        Vector2 temspeed1;
        Vector2 temspeed2;
        const float collision_distance = 10.0;

    protected:
        static void _bind_methods();

    public:
        CustomCollision();
        ~CustomCollision();

        void _ready();
        void _process(double delta);
    };

}

#endif // CUSTOM_COLLISION_H


