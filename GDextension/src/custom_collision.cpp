#include "custom_collision.h"

using namespace godot;

void CustomCollision::_bind_methods() {
    ClassDB::bind_method(D_METHOD("_ready"), &CustomCollision::_ready);
    ClassDB::bind_method(D_METHOD("_process", "delta"), &CustomCollision::_process);
}

CustomCollision::CustomCollision() { }
CustomCollision::~CustomCollision() { }

void CustomCollision::_ready() {
    rigid_body_a = get_node<RigidBody2D>("circle1");
    rigid_body_b = get_node<RigidBody2D>("circle2");

    rigid_body_a->set_linear_velocity(temspeed1);
    rigid_body_b->set_linear_velocity(temspeed2);
}

void CustomCollision::_process(double delta) {
    Vector2 position_a = rigid_body_a->get_position();
    Vector2 position_b = rigid_body_b->get_position();

    float distance = position_a.distance_to(position_b);
    if (distance < collision_distance) {
        rigid_body_a->set_linear_velocity(-rigid_body_a->get_linear_velocity());
        rigid_body_b->set_linear_velocity(-rigid_body_b->get_linear_velocity());
    }
}
